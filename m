Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVKJXlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVKJXlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVKJXlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:41:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:32922 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932273AbVKJXlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:41:22 -0500
Subject: Re: [RFC] sys_punchhole()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, hugh@veritas.com, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20051110153254.5dde61c5.akpm@osdl.org>
References: <1131664994.25354.36.camel@localhost.localdomain>
	 <20051110153254.5dde61c5.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 15:41:02 -0800
Message-Id: <1131666062.25354.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 15:32 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > We discussed this in madvise(REMOVE) thread - to add support 
> > for sys_punchhole(fd, offset, len) to complete the functionality
> > (in the future).
> > 
> > http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
> > 
> > What I am wondering is, should I invest time now to do it ?
> 
> I haven't even heard anyone mention a need for this in the past 1-2 years.
> 
> > Or wait till need arises ? 
> 
> A long wait, I suspect..
> 

Okay. I guess, I will wait till someone needs it.

I am just trying to increase my chances of "getting my madvise(REMOVE)
patch into mainline" :)

Thanks,
Badari

