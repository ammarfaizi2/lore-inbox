Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279822AbRKMPVe>; Tue, 13 Nov 2001 10:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280071AbRKMPVZ>; Tue, 13 Nov 2001 10:21:25 -0500
Received: from mustard.heime.net ([194.234.65.222]:6618 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280015AbRKMPVL>; Tue, 13 Nov 2001 10:21:11 -0500
Date: Tue, 13 Nov 2001 16:21:10 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: linux readahead setting?
Message-ID: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I heard linux does <= 32 page readahead from block devices
(scsi/ide/que?). Is there a way to double this? I want to read 256kB
chunks from the SCSI drives, as to get the best speed. These numbers are
based on some testing and information I've got from Compaq's storage guys.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

