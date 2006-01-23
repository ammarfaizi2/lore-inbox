Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWAWPW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWAWPW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWAWPW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:22:58 -0500
Received: from web26906.mail.ukl.yahoo.com ([217.146.176.95]:19027 "HELO
	web26906.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751472AbWAWPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:22:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gA4CPH1D97YF00B6z+i+/6Uzswj8AEmYcMiK+IbDsAy8Gs9Be4oUo7OhHvtwQ/8AdoOKP2pI/KUZoNxYZbk/g+/I/61l3vdk5fB70kBlrUOnfw7AcuOxyyKo/3eabrULP6Xb742kYYeC+H83ArU6AQYwb4QtmnzTuo9Kyz2IKzc=  ;
Message-ID: <20060123152251.85092.qmail@web26906.mail.ukl.yahoo.com>
Date: Mon, 23 Jan 2006 16:22:51 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: [ANNOUNCE] Gujin PC graphic bootloader version 1.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 For people following the bootloading process.

 Gujin v1.3 mainly fixes two bugs, one about bad logic loading
 a compressed initrd (data pattern dependant), one about reading
 files on FAT32 (for nearly full filesystems).
 Some other improvement are not completely related to Linux,
 but for instance there are tools to create contigous files
 on E2/3FS (with a hole at beginning) so that floppy simulation
 can work also on this filesystem, execution speed improvement
 for slow PCs, parameter passing for the TINY.EXE loader, and
 some more general improvements.

 Home page and screenshoots of Gujin at:
http://gujin.org

 More information for Gujin on Wikipedia:
http://en.wikipedia.org/wiki/Gujin

 Downloads at Sourceforge:
http://sourceforge.net/projects/gujin

 FAQ/HOWTO at sourceforge:
http://sourceforge.net/docman/display_doc.php?docid=1989&group_id=15465

  Have fun,
  Etienne.


	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
