Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262333AbTDALXQ>; Tue, 1 Apr 2003 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262399AbTDALXQ>; Tue, 1 Apr 2003 06:23:16 -0500
Received: from eri.interia.pl ([217.74.65.138]:5132 "EHLO eri.interia.pl")
	by vger.kernel.org with ESMTP id <S262333AbTDALXP> convert rfc822-to-8bit;
	Tue, 1 Apr 2003 06:23:15 -0500
Date: 01 Apr 2003 13:34:37 +0200
From: xperience@interia.pl
Subject: 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-EMID: e6740acc
X-ORIGINATE-IP: 192.168.0.99
Organization: INTERIA.PL S.A.
Message-Id: <20030401113437.958351FCF56@front.interia.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'v got problem with ide-scsi driver in 2.4.20, when I put that module in kernel it recognizes my drives as SCSI - good, but when I have more than one drive that can be emulated,i.e. CD-RW & DVD creates 16 scsi devices in /dev - /dev/sr(0-15). Devices from 0-7 are master on ribbon, and 8-15 secondary. I can access devices as usual. One more thing that when I have CD-RW and normal CD-R it recognizes one device wihich is cdrecorder, cdrom I can access as normal IDE device. That's all ;-) 

HW info:
MB: MSI 854PE Max
HDD: Seagate Barracuda IV 40GB
CD-RW: LG 48/12/48 HL-ST-8040B
CD-R: LG 52x



