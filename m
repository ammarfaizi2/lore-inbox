Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbSLLJZA>; Thu, 12 Dec 2002 04:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267460AbSLLJZA>; Thu, 12 Dec 2002 04:25:00 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:58246 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267459AbSLLJY7>;
	Thu, 12 Dec 2002 04:24:59 -0500
Date: Thu, 12 Dec 2002 10:32:55 +0100 (CET)
From: Stephan van Hienen <ultra@a2000.nu>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org
Subject: modprobe: Can't locate module personality-8
Message-ID: <Pine.LNX.4.50.0212121031450.23699-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dec 8 18:59:46 ddx modprobe: modprobe: Can't locate module personality-8
Dec 8 18:59:46 ddx modprobe: modprobe: Can't locate module personality-8
..
Dec 8 19:16:15 ddx modprobe: modprobe: Can't locate module personality-8
Dec 8 19:16:55 ddx last message repeated 6 times
Dec 8 19:17:06 ddx last message repeated 3 times
..
Dec 11 10:06:12 ddx modprobe: modprobe: Can't locate module personality-8
Dec 11 10:06:12 ddx modprobe: modprobe: Can't locate module personality-8


Did i forget to compile something in the kernel ?
(2.4.20 on sun ultrasparc)
