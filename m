Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUFPHJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUFPHJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUFPHJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:09:40 -0400
Received: from dialpool2-8.dial.tijd.com ([62.112.11.8]:8064 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S266200AbUFPHJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:09:39 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.7
Date: Wed, 16 Jun 2004 09:10:04 +0200
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406160910.05290.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 June 2004 07:56, Linus Torvalds wrote:
> Ok, it's out there. The most notable change may be the one-liner that
> should fix the embarrassing FP exception problem. Other than that, we've
> had a random collection of fixes and updates since rc3. cifs, ntfs,
> cpufreq. ide, sparc, s390.
>
> Full 2.6.6->2.6.7 changelog available at the same places the release is.
>
> 		Linus
>

Compiled and works fine on my Acer TM 803. As a nice sidenote, the screen 
corruption that was visible at the initial start of the radeon framebuffer is 
gone too.

Thanks for another great kernel :-)

Jan

-- 
Logic is a little bird, sitting in a tree; that smells *_____awful*.
