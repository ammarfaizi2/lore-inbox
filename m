Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286210AbRLJKER>; Mon, 10 Dec 2001 05:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286211AbRLJKEI>; Mon, 10 Dec 2001 05:04:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50694 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286210AbRLJKDy>; Mon, 10 Dec 2001 05:03:54 -0500
Subject: Re: Patches in 2.4.17-pre2 that aren't in 2.5.1-pre8
To: bunk@fs.tum.de (Adrian Bunk)
Date: Mon, 10 Dec 2001 10:10:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.43.0112101032230.4997-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Dec 10, 2001 10:51:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DNNu-0001VB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> patches that go into the stable kernel should also go into the development
> kernel. I was wondering how good this works and I was surprised that only

In many cases that isnt true, and for a lot of the pending patches its
pointless merging them into 2.5 until 2.5 gets into better shape. Going back
over them as you have done is something that does need doing, but not until
the block layer has some semblance of completion about it
