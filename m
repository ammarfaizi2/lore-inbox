Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266886AbUAXI1C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 03:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUAXI1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 03:27:02 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:34810 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id S266886AbUAXI0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 03:26:54 -0500
From: Mike Gabriel <mgabriel@ecology.uni-kiel.de>
Reply-To: mgabriel@ecology.uni-kiel.de
Organization: OEZK, CAU Kiel
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: vt6410 in kernel 2.6
Date: Sat, 24 Jan 2004 09:25:39 +0100
User-Agent: KMail/1.5.4
References: <200401222238.09157.mgabriel@ecology.uni-kiel.de> <200401240047.19261.mgabriel@ecology.uni-kiel.de> <4011B4C8.50908@pobox.com>
In-Reply-To: <4011B4C8.50908@pobox.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401240925.39986.mgabriel@ecology.uni-kiel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi jeff,

> >>>is there any chance of upcoming support for the vt6410 ide/raid chipset
> >>>in the 2.6.x kernel? there has been an attempt by via itself, but it
> >>> only suits redhat 7.2 kernels and systems, thus it is highly specific.
> >>> is there any1 who is working on that?
>
> CONFIG_BLK_DEV_GENERIC or CONFIG_SCSI_SATA_VIA should do it.
>

oh, i thought these options were for SATA only. what i need is the ide-part of 
the controller. is this support by these options, as well? i will try as soon 
as possible. i use a debian-backports kernel which for now always kills the 
system during kernel-image-boot. as i use the board in one of our servers, i 
cannot really fiddle around with it to much. thanks for your info.

mike gabriel

-- 

netzwerkteam - oekologiezentrum
Mike Gabriel
FA Geobotanik
Christian-Albrecht Universit‰t zu Kiel
Abt. Prof. Dr. K. Dierﬂen
Olshausenstr. 75
24118 kiel

fon-oezk: +49 431 880 1186
fon-home: +49 431 64 74 196

mail: mgabriel@ecology.uni-kiel.de
http://www.ecology.uni-kiel.de

