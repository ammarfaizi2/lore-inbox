Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbRESMTf>; Sat, 19 May 2001 08:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261797AbRESMTZ>; Sat, 19 May 2001 08:19:25 -0400
Received: from cs140085.pp.htv.fi ([213.243.140.85]:63846 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S261793AbRESMTN>; Sat, 19 May 2001 08:19:13 -0400
Message-ID: <3B066460.24E9EACB@pp.htv.fi>
Date: Sat, 19 May 2001 15:17:36 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VIA/PDC/Athlon - IDE error theory
In-Reply-To: <E150VHJ-0006Ak-00@the-village.bc.nu> <3B066184.5A6FA728@gmx.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann wrote:
> > > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > CRC errors are cable errors so that bit is reasonable in itself
> Could this be caused by the RAID configuration? The first sector of the

Yes, it's RAID5. But the error message is because of misdetected cable...

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
