Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279614AbRKFPJL>; Tue, 6 Nov 2001 10:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279596AbRKFPI6>; Tue, 6 Nov 2001 10:08:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50441 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279614AbRKFPIq>; Tue, 6 Nov 2001 10:08:46 -0500
Subject: Re: Mylex/Compaq RAID controller placement in config
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Tue, 6 Nov 2001 15:15:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111061519320.23668-100000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Nov 06, 2001 03:22:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1617xB-0000ln-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I apologize if this is a well-stressed question, but why is the Mylex and
> Compaq RAID controllers placed under 'Block devices' rather than under
> 'SCSI'?

Because they are ?

They dont provide scsi as the native interface (nor do some of the others
but thats a seperate saga)
