Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRDTXwq>; Fri, 20 Apr 2001 19:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDTXwf>; Fri, 20 Apr 2001 19:52:35 -0400
Received: from eispost12.serverdienst.de ([212.168.16.111]:6672 "EHLO imail")
	by vger.kernel.org with ESMTP id <S132226AbRDTXvi>;
	Fri, 20 Apr 2001 19:51:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: Wayne.Brown@altec.com
Subject: Re: Current status of NTFS support
Date: Sat, 21 Apr 2001 01:55:56 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042101555600.03154@blackbox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where does write support for NTFS stand at the moment?  I noticed that it's
> still marked "Dangerous" in the kernel configuration.  This is important to
> me because it looks like I'll have to start using it next week.  My office
> laptop is going to be "upgraded" from Windows 98 to 2000.  Of course, I
> hardly ever boot into Windows any more since installing a Linux partition
> last year.  But our corporate email standard forces me to use Lotus Notes,
> which I run under Wine.   The Notes executables and databases are installed
> on my Windows partition.  The upgrade, though, will involve wiping the hard
> drive, allocating the whole drive to a single NTFS partition, and
> reinstalling Notes after installing Windows 2000 .  That means bye-bye
> FAT32 partition and hello NTFS.  I can't mount it read-only because I'll
> still have to update my Notes databases from Linux.  So how risky is this?

I would not recommend enabling NTFS write support for the moment...
Why don't you install Windows 2000 on a FAT32 partition (choose FAT32 during 
installation)?
It's no problem running Win2k on a FAT32 partition if you don't need NTFS 
ACLs.

>
> Also, I'll have to recreate my Linux partitions after the upgrade.  Does
> anyone know if FIPS can split a partition safely that was created under
> Windows 2000/NT?  It worked fine for Windows 98, but I'm a little worried
> about what might happen if I try to use it on an NTFS partition.
This will not work AFAIK
>
> I'd appreciate any advice or help anyone can give me.  There's just no way
> I can stand going back to using anything but Linux for my daily work.
>
> Wayne
>

 Regards,
   Robert
