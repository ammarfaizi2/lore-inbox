Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbREYXGr>; Fri, 25 May 2001 19:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbREYXGh>; Fri, 25 May 2001 19:06:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262012AbREYXGY>; Fri, 25 May 2001 19:06:24 -0400
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
To: nemosoft@smcc.demon.nl (Nemosoft Unv.)
Date: Sat, 26 May 2001 00:03:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), johannes@erdfelt.com,
        linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org (Erik Mouw), J.A.K.Mouw@ITS.TUDelft.NL,
        randy.dunlap@intel.com
In-Reply-To: <XFMail.010525213709.nemosoft@smcc.demon.nl> from "Nemosoft Unv." at May 25, 2001 09:37:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153QcH-0007CW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> all at the same time). I will *not* have a crippled driver into the Lin=
> ux
> kernel. If this is going to be policy, fine. But then this policy will =
> apply
> to ALL drivers equally, not just mine because suddenly Alan realizes he=

I've had the others on the list for a while too, jus this one was very easy
to fix and mindbogglingly annoying

> been sleeping for the past 5 years and decides to implement a policy ha=
> rdly
> noone ever knew existed.

The policy has been there since day 1. This is a kernel not a library. You've
written some very nice conversion library routines and I do hope you contribute
those in userspace where they belong

