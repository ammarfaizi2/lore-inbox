Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130312AbRAaRm3>; Wed, 31 Jan 2001 12:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRAaRmU>; Wed, 31 Jan 2001 12:42:20 -0500
Received: from 4dyn210.com21.casema.net ([212.64.95.210]:40974 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130312AbRAaRmM>;
	Wed, 31 Jan 2001 12:42:12 -0500
Date: Wed, 31 Jan 2001 18:41:53 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Vanilla 2.4.0 ext2fs error
Message-ID: <20010131184152.A3287@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101311805470.29461-100000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.LNX.4.30.0101311805470.29461-100000@jdi.jdimedia.nl>; from i.palsenberg@jdimedia.nl on Wed, Jan 31, 2001 at 06:21:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 06:21:04PM +0100, Igmar Palsenberg wrote:

> Jan 31 18:01:57 base kernel: EXT2-fs error (device ide0(3,71)):
> ext2_new_inode:
> reserved inode or inode > inodes count - block_group = 0,inode=1

does fsck run on this fs find any errors?

> Igmar Palsenberg
> JDI Media Solutions

Huge .sig!

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
