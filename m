Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRDUDlJ>; Fri, 20 Apr 2001 23:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132473AbRDUDlA>; Fri, 20 Apr 2001 23:41:00 -0400
Received: from james.kalifornia.com ([208.179.59.2]:35880 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S132468AbRDUDkq>; Fri, 20 Apr 2001 23:40:46 -0400
Message-ID: <3AE0F1F9.7020704@kalifornia.com>
Date: Fri, 20 Apr 2001 19:35:37 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; rv:0.8.1+) Gecko/20010416
X-Accept-Language: en
MIME-Version: 1.0
To: Wayne.Brown@altec.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:

>
>Where does write support for NTFS stand at the moment?  I noticed that it's
>still marked "Dangerous" in the kernel configuration.  This is important to me
>because it looks like I'll have to start using it next week.  My office laptop
>is going to be "upgraded" from Windows 98 to 2000.  Of course, I hardly ever
>boot into Windows any more since installing a Linux partition last year.  But
>our corporate email standard forces me to use Lotus Notes, which I run under
>Wine.   The Notes executables and databases are installed on my Windows
>partition.  The upgrade, though, will involve wiping the hard drive, allocating
>the whole drive to a single NTFS partition, and reinstalling Notes after
>installing Windows 2000 .  That means bye-bye FAT32 partition and hello NTFS.  I
>can't mount it read-only because I'll still have to update my Notes databases
>from Linux.  So how risky is this?
>
>Also, I'll have to recreate my Linux partitions after the upgrade.  Does anyone
>know if FIPS can split a partition safely that was created under Windows
>2000/NT?  It worked fine for Windows 98, but I'm a little worried about what
>might happen if I try to use it on an NTFS partition.
>
>I'd appreciate any advice or help anyone can give me.  There's just no way I can
>stand going back to using anything but Linux for my daily work.
>

Why not just use FAT?  Windows2k supports it . . .

-- 
Three things are certain:
Death, taxes, and lost data
Guess which has occurred.
- - - - - - - - - - - - - - - - - - - -
Patched Micro$oft servers are secure today . . . but tomorrow is another story!



