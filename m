Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRLGMgI>; Fri, 7 Dec 2001 07:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277918AbRLGMf6>; Fri, 7 Dec 2001 07:35:58 -0500
Received: from ns.suse.de ([213.95.15.193]:9746 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277532AbRLGMft>;
	Fri, 7 Dec 2001 07:35:49 -0500
Date: Fri, 7 Dec 2001 13:35:48 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Thomas Braun <tb@westend.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.15
In-Reply-To: <3C10B4BA.6090303@westend.com>
Message-ID: <Pine.LNX.4.33.0112071333580.25132-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Thomas Braun wrote:

> can someone tell me what is going wrong with my kernel?

Two choices.. 1, downgrade binutils. or 2, dig out the various
patches posted here over the last few days. Subject lines
were similar to the text.exit error message.

Incidentally, you don't want to be running 2.4.15.
Read the archives regarding corruption-on-umount.

dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


