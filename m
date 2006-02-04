Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWBDSP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWBDSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWBDSP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 13:15:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5137 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932541AbWBDSP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 13:15:57 -0500
Date: Sat, 4 Feb 2006 19:15:54 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Mathias Kretschmer <posting@blx4.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Kernel Useful Patches (2.4)
Message-ID: <20060204181554.GG6026@w.ods.org>
References: <20060130085233.GA1498@w.ods.org> <43E27895.4010904@blx4.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E27895.4010904@blx4.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 10:24:37PM +0100, Mathias Kretschmer wrote:
> Willy Tarreau wrote:
> >Hi all,
> >
> >after some discussions with some people, I made available a collection of
> >useful patches for kernel 2.4. There are only a dozen of patches right
> >now, but it's very easy to add more. Amongst those patches can be found
> >some drivers, security enhancements, polling optimisations, gcc4 fixes,
> >VM optimisations, etc... Links to the original sites as well as a local
> >mirror are provided.
> >
> >They are classified by categories and can easily be found in more than
> >one category. I plan to add many more patches such as ACL, squashfs,
> >preempt, netdev-random, patch-o-matic, etc... when I have the time, and
> 
> O(1) and low latency would also be interesting candidates for inclusion.

The last O(1) patch I've seen does not apply to kernels more recent than 2.4.19
(it's on Ingo's site). Do you have any up to date pointer that I could use ?
However, I have a local rediff of the lowlat patch that I will include.

> BTW, does anyone know about the state of the (l)ck patches for recent 
> 2.4 kernels ?

No idea.

Regards,
Willy

