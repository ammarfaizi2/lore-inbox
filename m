Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRLBOwo>; Sun, 2 Dec 2001 09:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279805AbRLBOwe>; Sun, 2 Dec 2001 09:52:34 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:39593 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279768AbRLBOwV>; Sun, 2 Dec 2001 09:52:21 -0500
Date: Sun, 2 Dec 2001 16:56:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <bonganilinux@mweb.co.za>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Compilation error on 2.5.1-pre4
Message-ID: <Pine.LNX.4.33.0112021648270.9851-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its due to the block I/O layer changes Jens Axboe is currently
undertaking, expect breakage as a result. Tested patches are very
welcome at this stage though ;)

Cheers,
	Zwane Mwaikambo


