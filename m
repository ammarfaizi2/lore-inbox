Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbRDUKlB>; Sat, 21 Apr 2001 06:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRDUKkv>; Sat, 21 Apr 2001 06:40:51 -0400
Received: from www.nobugconsulting.ro ([212.93.142.140]:41478 "EHLO
	nobugconsulting.ro") by vger.kernel.org with ESMTP
	id <S132557AbRDUKkj>; Sat, 21 Apr 2001 06:40:39 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses
Date: Sat, 21 Apr 2001 13:35:30 +0300 (EEST)
From: <lk@aniela.eu.org>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.21.0104211333400.14048-100000@ns1.aniela.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have installed a Win2000 and you do not have to switch to NTFS. W2000
can be installed on a FAT32 partition. I have installed it on a FAT32
partition and hasn't caused me any problems.

You might wanna give it a try.

good luck,

/me

On Fri, 20 Apr 2001 Wayne.Brown@altec.com wrote:

> 
> 
> Where does write support for NTFS stand at the moment?  I noticed that it's
> still marked "Dangerous" in the kernel configuration.  This is important to me
> because it looks like I'll have to start using it next week.  My office laptop
> is going to be "upgraded" from Windows 98 to 2000.  Of course, I hardly ever
> boot into Windows any more since installing a Linux partition last year.  But
> our corporate email standard forces me to use Lotus Notes, which I run under
> Wine.   The Notes executables and databases are installed on my Windows
> partition.  The upgrade, though, will involve wiping the hard drive, allocating
> the whole drive to a single NTFS partition, and reinstalling Notes after
> installing Windows 2000 .  That means bye-bye FAT32 partition and hello NTFS.  I
> can't mount it read-only because I'll still have to update my Notes databases
> from Linux.  So how risky is this?
> 
> Also, I'll have to recreate my Linux partitions after the upgrade.  Does anyone
> know if FIPS can split a partition safely that was created under Windows
> 2000/NT?  It worked fine for Windows 98, but I'm a little worried about what
> might happen if I try to use it on an NTFS partition.
> 
> I'd appreciate any advice or help anyone can give me.  There's just no way I can
> stand going back to using anything but Linux for my daily work.
> 
> Wayne
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

