Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279983AbRKMOgP>; Tue, 13 Nov 2001 09:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKMOgF>; Tue, 13 Nov 2001 09:36:05 -0500
Received: from mustard.heime.net ([194.234.65.222]:54745 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S277612AbRKMOf7>; Tue, 13 Nov 2001 09:35:59 -0500
Date: Tue, 13 Nov 2001 15:35:57 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Linux file system block sizes
Message-ID: <Pine.LNX.4.30.0111131533400.994-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On what systems can Linux support file system block sizes above 4kB? I
read that it's not supported on ia32, so where is it? If I've understood
SCSI systems tuning right, a block size of 256kB would be perfect for the
hardware (see my last email). And - yes - I'm talking about serving large
files :-)

Thanks

roy
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

