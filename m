Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136045AbRDVLwT>; Sun, 22 Apr 2001 07:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136046AbRDVLwJ>; Sun, 22 Apr 2001 07:52:09 -0400
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:55449 "EHLO gin")
	by vger.kernel.org with ESMTP id <S136045AbRDVLv4>;
	Sun, 22 Apr 2001 07:51:56 -0400
Date: Sun, 22 Apr 2001 13:53:59 +0200
To: linux-kernel@vger.kernel.org
Subject: ide dma in /proc/dma
Message-ID: <20010422135359.A21013@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

why doesnt the dma for ide disks show up in /proc/dma?

heineken:~# hdparm -d /dev/discs/disc0/disc 
/dev/discs/disc0/disc:
 using_dma    =  1 (on)

heineken:~# cat /proc/dma 
 4: cascade
 

-- 

//anders/g

