Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSGGKh0>; Sun, 7 Jul 2002 06:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSGGKhZ>; Sun, 7 Jul 2002 06:37:25 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:16754 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315413AbSGGKhZ>; Sun, 7 Jul 2002 06:37:25 -0400
Date: Sun, 7 Jul 2002 04:39:47 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ata_special_intr, ide_do_drive_cmd deadlock
In-Reply-To: <Pine.LNX.4.44.0207071251530.1441-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0207070438330.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 7 Jul 2002, Zwane Mwaikambo wrote:
> The trace is quite nice on this one.
> 
> [trace followed immediately]

Have you tried IDE 96+97 yet? They changed ata_special_intr and 
ide_do_drive_cmd heavily.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

