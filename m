Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280134AbRJaKpz>; Wed, 31 Oct 2001 05:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280140AbRJaKpp>; Wed, 31 Oct 2001 05:45:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38925 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280134AbRJaKpe>; Wed, 31 Oct 2001 05:45:34 -0500
Subject: Re: ECS k7s5a motherboard doesnt work
To: warp@mercury.d2dc.net (Zephaniah E\. Hull)
Date: Wed, 31 Oct 2001 10:52:10 +0000 (GMT)
Cc: Crazed_Cowboy@stones.com (Justin Mierta),
        alan@lxorguk.ukuu.org.uk (Alan Cox), hahn@physics.mcmaster.ca,
        lung@theuw.net, linux-kernel@vger.kernel.org
In-Reply-To: <20011031033018.A1917@babylon.d2dc.net> from "Zephaniah E\. Hull" at Oct 31, 2001 03:30:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ysyg-0003Gw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only problems I have seen with this board are that I can't find
> drivers for the sound (no big loss), lmsensors does not seem to be able

[ALSA has one I believe]

> to properly read the sensors (annoying), repeated 'VFS: Disk change
> detected on device ide1(22,0)' messages (my cdrom drive, getting a
> little annoying), and, thats about it.

rpm -e magicdev
