Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129975AbQKWJvq>; Thu, 23 Nov 2000 04:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131049AbQKWJvg>; Thu, 23 Nov 2000 04:51:36 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:19213 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129975AbQKWJv1>; Thu, 23 Nov 2000 04:51:27 -0500
Date: Thu, 23 Nov 2000 03:21:17 -0600
To: haul@informatik.tu-darmstadt.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.0-test11 freezes when writing to FAT SCSI-MO-Drive
Message-ID: <20001123032117.Q2918@wire.cadcamlab.org>
In-Reply-To: <20001123093436.A1132@bremen.dvs1.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001123093436.A1132@bremen.dvs1.informatik.tu-darmstadt.de>; from haul@dvs1.informatik.tu-darmstadt.de on Thu, Nov 23, 2000 at 09:34:36AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Christian Haul]
> 2.4.0-test11 freezes when writing to FAT SCSI-MO-Drive  

I think this is a known problem with FAT vs. large block sizes.
I imagine it will be addressed soon.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
