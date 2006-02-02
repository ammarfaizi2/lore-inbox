Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWBBVW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWBBVW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWBBVW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:22:58 -0500
Received: from smtp3.netcologne.de ([194.8.194.66]:35537 "EHLO
	smtp3.netcologne.de") by vger.kernel.org with ESMTP id S932261AbWBBVW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:22:57 -0500
Message-ID: <43E27895.4010904@blx4.net>
Date: Thu, 02 Feb 2006 22:24:37 +0100
From: Mathias Kretschmer <posting@blx4.net>
User-Agent: Mail/News 1.5 (X11/20060117)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Kernel Useful Patches (2.4)
References: <20060130085233.GA1498@w.ods.org>
In-Reply-To: <20060130085233.GA1498@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi all,
> 
> after some discussions with some people, I made available a collection of
> useful patches for kernel 2.4. There are only a dozen of patches right
> now, but it's very easy to add more. Amongst those patches can be found
> some drivers, security enhancements, polling optimisations, gcc4 fixes,
> VM optimisations, etc... Links to the original sites as well as a local
> mirror are provided.
> 
> They are classified by categories and can easily be found in more than
> one category. I plan to add many more patches such as ACL, squashfs,
> preempt, netdev-random, patch-o-matic, etc... when I have the time, and

O(1) and low latency would also be interesting candidates for inclusion.

BTW, does anyone know about the state of the (l)ck patches for recent 
2.4 kernels ?

> possibly start the same work for 2.6 (everything has been prepared in
> order to make it easy too).
> 
> If there are patches you frequently use and wish to be added there,
> feel free to send a link and description.
> 
> At the moment, it's hosted on my home server. If it generates too much
> traffic, I'll move it somewhere else.
> 
>   link:  http://w.ods.org/kernel/2.4/lkup/
> 
> Regards,
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

