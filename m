Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbRLFOET>; Thu, 6 Dec 2001 09:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285138AbRLFOEM>; Thu, 6 Dec 2001 09:04:12 -0500
Received: from mustard.heime.net ([194.234.65.222]:24775 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S285135AbRLFOEC>; Thu, 6 Dec 2001 09:04:02 -0500
Date: Thu, 6 Dec 2001 15:03:47 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: temporarily system freeze with high I/O write to ext2 fs
Message-ID: <Pine.LNX.4.30.0112061458360.15516-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

why is it that Linux 'hangs' while doing heavy I/O operations (such as dd)
to (and perhaps from?) ext2 file systems? I can't see the same behaivour
when using other file systems, such as ReiserFS

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


