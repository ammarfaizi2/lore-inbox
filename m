Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTAWQrO>; Thu, 23 Jan 2003 11:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTAWQrO>; Thu, 23 Jan 2003 11:47:14 -0500
Received: from [81.2.122.30] ([81.2.122.30]:14341 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265469AbTAWQrM>;
	Thu, 23 Jan 2003 11:47:12 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301231656.h0NGulDr001498@darkstar.example.net>
Subject: Re: Expand VM
To: sneakums@zork.net (Sean Neakums)
Date: Thu, 23 Jan 2003 16:56:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6uy95bakrx.fsf@zork.zork.net> from "Sean Neakums" at Jan 23, 2003 04:33:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Use a swap-file on another machine on the LAN to extend your
> >> virtual memory if you run out of local swap-file space.
> >
> > What would be really good would be a multiple gigabyte solid state
> > 'disk', on a shared SCSI bus...
> 
> If you can afford gigabytes of solid state memory, you can surely
> afford to properly fit your boxes out in the first place.

Good point :-)

What I'd really like to see is a single device which appears as two
logical IDE or SCSI devices, one of which has 512 Mb of battery backed
RAM, and the other one 512 Mb of EEPROM.

No need for expensive flash memory, just cheap DRAM, and a few NiMH
cells to keep the RAM contents intact when the main power was
disconnected.

I've seen loads of solid state devices based on flash memory, but few
that are based on battery backed DRAM :-(.

John.
