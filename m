Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbVKPSjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbVKPSjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVKPSjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:39:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40874 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030433AbVKPSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:39:00 -0500
Date: Sun, 13 Nov 2005 15:09:06 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, andrea@suse.de, hugh@veritas.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] sys_punchhole()
Message-ID: <20051113150906.GA2193@spitz.ucw.cz>
References: <1131664994.25354.36.camel@localhost.localdomain> <20051110153254.5dde61c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110153254.5dde61c5.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We discussed this in madvise(REMOVE) thread - to add support 
> > for sys_punchhole(fd, offset, len) to complete the functionality
> > (in the future).
> > 
> > http://marc.theaimsgroup.com/?l=linux-mm&m=113036713810002&w=2
> > 
> > What I am wondering is, should I invest time now to do it ?
> 
> I haven't even heard anyone mention a need for this in the past 1-2 years.

Some database people wanted it maybe month ago. It was replaced by some 
madvise hack...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

