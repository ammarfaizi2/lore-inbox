Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262921AbREWA3w>; Tue, 22 May 2001 20:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbREWA3n>; Tue, 22 May 2001 20:29:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:14276 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262921AbREWA3c>;
	Tue, 22 May 2001 20:29:32 -0400
Date: Wed, 23 May 2001 02:28:55 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105230028.CAA79596.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [PATCH] struct char_device
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	dev_t rdev;

> Reasonable.

Good. We all agree.
(But now you see what I meant in comments about mknod.)

>> 	kdev_t dev;

> Useless. If you hope that block_device will help to solve rmmod races

Yes. Why am I mistaken?

Andries
