Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQLHPb5>; Fri, 8 Dec 2000 10:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbQLHPbh>; Fri, 8 Dec 2000 10:31:37 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:57328 "EHLO
	tantra.cygnus.co.uk") by vger.kernel.org with ESMTP
	id <S129415AbQLHPb2>; Fri, 8 Dec 2000 10:31:28 -0500
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: patch: test12-pre7 cd stuff 
In-Reply-To: Your message of "Fri, 08 Dec 2000 15:45:16 +0100."
             <20001208154516.D303@suse.de> 
Date: Fri, 08 Dec 2000 15:00:56 +0000
Message-ID: <20048.976287656@warthog.cygnus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dec  8 06:05:29 agate kernel: hdc: packet command error: status=0x51 { 
> DriveReady SeekComplete Error }
> Dec  8 06:05:29 agate kernel: hdc: packet command error: error=0x50
> Dec  8 06:05:29 agate kernel: ATAPI device hdc:
> Dec  8 06:05:29 agate kernel:   Error: Illegal request -- (Sense key=0x05)
> Dec  8 06:05:29 agate kernel:   Invalid field in command packet -- 
> (asc=0x24, ascq=0x00)
> Dec  8 06:05:29 agate kernel:   The failed "Play Audio MSF" packet 
> command was:
> Dec  8 06:05:29 agate kernel:   "47 00 00 00 02 00 3f 24 ff 00 00 00 "

I think I've seen that as well, though I'm using a test10-ish kernel. I
assumed it was something to do with the CD being duff though.

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
