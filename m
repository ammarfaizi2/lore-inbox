Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSGGQ4f>; Sun, 7 Jul 2002 12:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSGGQ4e>; Sun, 7 Jul 2002 12:56:34 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:29645 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316167AbSGGQ4e>; Sun, 7 Jul 2002 12:56:34 -0400
Date: Sun, 7 Jul 2002 19:17:08 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ata_special_intr, ide_do_drive_cmd deadlock
In-Reply-To: <Pine.SOL.4.30.0207071853410.1945-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0207071916040.1441-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2002, Bartlomiej Zolnierkiewicz wrote:

> 
> If it was IDE 95, or IDE 95 on atapi device it is known, noted in 95's
> changelog and fixed in 96...

On ATA disk, with 2.5.25 stock and the deadlock is still there (visual 
inspection) in IDE 97

Cheers,
	Zwane Mwaikambo
-- 
function.linuxpower.ca

