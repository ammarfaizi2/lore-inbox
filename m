Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265018AbSIWChC>; Sun, 22 Sep 2002 22:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbSIWChC>; Sun, 22 Sep 2002 22:37:02 -0400
Received: from mnh-1-27.mv.com ([207.22.10.59]:34820 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265018AbSIWChB>;
	Sun, 22 Sep 2002 22:37:01 -0400
Message-Id: <200209230345.WAA05699@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] n_tty.c buglet breaks error returns 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Sep 2002 22:45:49 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That was a bogus patch, sorry.  2.4.19 had the test right, my local pool
didn't.  I had applied an earlier version of the patch, and didn't look
carefully enough at the rejects when I applied the 2.4.19 patch to it.

				Jeff

