Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292667AbSBQB3B>; Sat, 16 Feb 2002 20:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292669AbSBQB2v>; Sat, 16 Feb 2002 20:28:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:24717 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292667AbSBQB2k>;
	Sat, 16 Feb 2002 20:28:40 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 17 Feb 2002 01:28:38 GMT
Message-Id: <UTC200202170128.BAA31560.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [OOPS] Linux 2.5 and Parallel Port Zip 100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that booting 2.5.* with a disk in the ZIP drive
causes an immediate crash. Also, that this is fixed by
the patch by Rich Baum from a few days ago.

Andries
