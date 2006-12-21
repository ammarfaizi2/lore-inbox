Return-Path: <linux-kernel-owner+w=401wt.eu-S1423079AbWLUUkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423079AbWLUUkN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423081AbWLUUkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:40:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:48882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423079AbWLUUkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:40:11 -0500
X-Authenticated: #20450766
Date: Thu, 21 Dec 2006 21:40:05 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jeff Garzik <jeff@garzik.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated Kernel Hacker's guide to git
In-Reply-To: <4589F9B1.2020405@garzik.org>
Message-ID: <Pine.LNX.4.60.0612212135230.5551@poirot.grange>
References: <4589F9B1.2020405@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Jeff Garzik wrote:

> I refreshed my git intro/cookbook for kernel hackers, at
> http://linux.yyz.us/git-howto.html

Very nice, thanks! A couple of remarks from an absolute git newbie:

1. I heard "git am" is supposed to supersede apply-mbox

2. What I often have problems with is - what to do if git spits at me a 
bunch of conflict messages after a seemingly safe pull or similar. Don't 
know if you want to cover those points but "git troubleshooting" would 
definitely be a valuable document.

Thanks
Guennadi
---
Guennadi Liakhovetski
