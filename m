Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTAPHS4>; Thu, 16 Jan 2003 02:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbTAPHS4>; Thu, 16 Jan 2003 02:18:56 -0500
Received: from smtp05.wxs.nl ([195.121.6.57]:4796 "EHLO smtp05.wxs.nl")
	by vger.kernel.org with ESMTP id <S261799AbTAPHSz>;
	Thu, 16 Jan 2003 02:18:55 -0500
Date: Thu, 16 Jan 2003 08:29:31 +0100 (CET)
From: Ferry van Steen <freaky@www.bananateam.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Partially closed source module, more of gcc/ld question.
Message-ID: <Pine.LNX.4.33.0301160825140.6306-100000@www.bananateam.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

some of you might have read my message on the promise fasttrak last time.
I'm sorry to say that I started yelling to them through e-mail and the
replied now! This is the so manied company that suddenly replies if you
yell... Oh well, they released some new module, which I want to try later
on.

Sortta like nvidia, you get a Makefile, some others an object and 3 C
files. Now for the question. Loading a gcc v2 compiled module into a v3
compiled kernel causes problems. Is it correct to assume then that if the
object were compiled with v2, and the C files with v3 and those get linked
together into a module, that you might experience the same problems?

Is there any way I can see with which version the object was compiled
(the kernel seems to be able to, or atleast, partially it doesn't give
specific version just v2 or v3)?

Kind regards


