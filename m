Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbTCOCkl>; Fri, 14 Mar 2003 21:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbTCOCkl>; Fri, 14 Mar 2003 21:40:41 -0500
Received: from lucidpixels.com ([66.45.37.187]:8972 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S261305AbTCOCkl>;
	Fri, 14 Mar 2003 21:40:41 -0500
Date: 15 Mar 2003 02:51:30 -0000
Message-ID: <20030315025130.10845.qmail@lucidpixels.com>
From: war@lucidpixels.com
To: linux-kernel@vger.kernel.org
Subject: Broadcom NIC..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should be marked -not- ready yet, tried several different combinations in order to get the NIC to work, however it ow
would only work if I let everything load first, then whe  wen* went* in and i manually insmoded the tg3.o module (when it hookes hooks to IRQ5, then it works) , nrb -- but normally it is on IRQ18, and it never works when it attaches to this IRQ, I guess I'll have to use a 3com card for now until wthese problesmms get fixed?
..
