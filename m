Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131755AbRCUTVr>; Wed, 21 Mar 2001 14:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131746AbRCUTVg>; Wed, 21 Mar 2001 14:21:36 -0500
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:4019 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S131724AbRCUTSy>; Wed, 21 Mar 2001 14:18:54 -0500
Message-ID: <3AB8FE73.63E3F9A7@bigfoot.com>
Date: Wed, 21 Mar 2001 11:18:11 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010320202020Z130768-406+2207@vger.kernel.org>
		<Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca> <20010321095533Z131410-407+1932@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1       932   7486258+   b  Win95 FAT32

Try changing to 'c' (fat32+LBA) and check BIOS settings (s/b AUTO or USER,
and LBA).

rgds,
tim.
--
