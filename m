Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281196AbRKPC44>; Thu, 15 Nov 2001 21:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281197AbRKPC4q>; Thu, 15 Nov 2001 21:56:46 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:14247 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S281196AbRKPC4e>; Thu, 15 Nov 2001 21:56:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: Tuning Linux for high-speed disk subsystems
Date: Fri, 16 Nov 2001 03:56:19 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011116025639Z281196-17408+14879@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The heroinewarrior.com (Broadcast 2000) guys came to the following with the
Tyan Thunder K7 (2 x 1.0 GHz Athlon MP) dual channel U160 (Adaptec) and
RAID 0. http://heroinewarrior.com/athlon.php3

[-]
 As for performance our experiences are biased because this system is almost 
exclusively used for video software development not games like most. It needs 
a reliable operating system like Linux and very fast media storage drives.

 The inverse telecine, a grueling memory excercise which takes 3 hours on a 
dual PIII 933 and 2 hours on a dual Alpha, takes about 2 hours on the dual 
Athlon. 

Our 100 Gig SCSI raid, consisting of 6 15,000 rpm drives on the motherboard's 
two SCSI 160 channels gives a full 110MB/sec read and write with RAID 0. With 
RAID chunks set to 1MB the write accesses go to 160MB/sec and read accesses 
go to 90MB/sec sustained. This system would make a good motion capture tool. 
Previous Intel attempts at onboard disk I/O would give 50MB/sec.
[-]

-Dieter
