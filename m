Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSBGHqi>; Thu, 7 Feb 2002 02:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSBGHqa>; Thu, 7 Feb 2002 02:46:30 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:45273 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285709AbSBGHqU>; Thu, 7 Feb 2002 02:46:20 -0500
Date: Thu, 7 Feb 2002 09:39:20 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Oops after disabling DMA with IDE-SCSI
In-Reply-To: <Pine.LNX.4.44.0202070911321.8308-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0202070938470.8308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correction, looks like hdparm -d0 doesn't trigger an oops.

Regards,
	Zwane Mwaikambo


