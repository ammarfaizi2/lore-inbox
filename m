Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbULZLmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbULZLmA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 06:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbULZLmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 06:42:00 -0500
Received: from spc1-cosh5-3-0-cust149.cosh.broadband.ntl.com ([81.102.80.149]:35777
	"EHLO central.regress.homelinux.org") by vger.kernel.org with ESMTP
	id S261639AbULZLl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 06:41:58 -0500
From: Grahame White <grahame@regress.homelinux.org>
Reply-To: grahame@regress.homelinux.org
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
Date: Sun, 26 Dec 2004 11:41:48 +0000
User-Agent: KMail/1.7.1
References: <200412260917.38717.nick@linicks.net> <20041226132047.6ac71b4f@hotline4.alkar.net> <200412261136.18751.nick@linicks.net>
In-Reply-To: <200412261136.18751.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412261141.49017.grahame@regress.homelinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 11:36, Nick Warne wrote:
> On Sunday 26 December 2004 11:20, Roman Ivanchukov wrote:
>
> Strange - really strange.  I was specific on that line as that is what
> GCC told me error was - and it was here.
>
> > I've just downloaded linux-2.6.10.tar.bz2 from kernel.org and there is
> > no such error in netfilter.h:
> >
> > /* Call setsockopt() */
> > int nf_setsockopt(struct sock *sk, int pf, int optval, char __user
> > *opt, int len);
>
> I just DL'ed the tar.gz - that is OK.
>
> The image build I done (using oldconfig) booted, but wouldn't mount
> disks, and a few other errors (like looking for modules - I don't build
> with modules).
>
> What on earth could cause that then?  Corrupt download?  I would have
> thought nigh on impossible to get one or two errors like that if so?
>
> Nick

Did you try checking the md5 of the tar.bz2?

Grahame
