Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbVKPWBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbVKPWBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVKPWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:01:19 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:36504 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030467AbVKPWBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:01:19 -0500
Subject: Re: [RFC] sys_punchhole()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, hugh@veritas.com,
       lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20051113150906.GA2193@spitz.ucw.cz>
References: <1131664994.25354.36.camel@localhost.localdomain>
	 <20051110153254.5dde61c5.akpm@osdl.org>
	 <20051113150906.GA2193@spitz.ucw.cz>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 14:01:10 -0800
Message-Id: <1132178470.24066.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-13 at 15:09 +0000, Pavel Machek wrote:
> Hi!
> 
> > > We discussed this in madvise(REMOVE) thread - to add support 
> > > for sys_punchhole(fd, offset, len) to complete the functionality
> > > (in the future).
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
> > > 
> > > What I am wondering is, should I invest time now to do it ?
> > 
> > I haven't even heard anyone mention a need for this in the past 1-2 years.
> 
> Some database people wanted it maybe month ago. It was replaced by some 
> madvise hack...

Hmm. Someone other than me asking for it ? 

I did the madvise() hack and asking to see if any one really needs
sys_punchole().

Thanks,
Badari

