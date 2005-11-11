Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVKKQwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVKKQwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 11:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVKKQwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 11:52:40 -0500
Received: from mail.linicks.net ([217.204.244.146]:39579 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750904AbVKKQwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 11:52:40 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.1/2 patch Makefile hunk FAILED
Date: Fri, 11 Nov 2005 16:52:34 +0000
User-Agent: KMail/1.8.1
Cc: Greg KH <gregkh@suse.de>, Chris Wright <chrisw@osdl.org>
References: <200511111648.35632.nick@linicks.net>
In-Reply-To: <200511111648.35632.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111652.34668.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, wasting your time.  I am an _idiot_.

Nick

On Friday 11 November 2005 16:48, Nick Warne wrote:
> Hi all,
>
> Just an eyes-up here - applying the combined 2.6.14.1/2 patch from
> kernel.org
>
> http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6
>%2Fincr%2Fpatch-2.6.14.1-2.bz2
>
> produces REJ on Makefile when applied to virgin 2.6.14 as EXTRAVERSION
> isn't .1:
>
>
> ***************
> *** 1,7 ****
>   VERSION = 2
>   PATCHLEVEL = 6
>   SUBLEVEL = 14
> - EXTRAVERSION = .1
>   NAME=Affluent Albatross
>
>   # *DOCUMENTATION*
> --- 1,7 ----
>   VERSION = 2
>   PATCHLEVEL = 6
>   SUBLEVEL = 14
> + EXTRAVERSION = .2
>   NAME=Affluent Albatross
>
>   # *DOCUMENTATION*
>
>
>
> Simple to fix manually though.
>
> Nick

-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

