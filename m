Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263431AbRFFA4R>; Tue, 5 Jun 2001 20:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263432AbRFFA4I>; Tue, 5 Jun 2001 20:56:08 -0400
Received: from gec.gecpalau.com ([206.49.60.67]:26630 "EHLO gec.gecpalau.com")
	by vger.kernel.org with ESMTP id <S263431AbRFFAzt>;
	Tue, 5 Jun 2001 20:55:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Glenn Shannon <glenn@gecpalau.com>
To: linux-kernel@vger.kernel.org
Subject: Lockup in 2.4.5-ac2
Date: Wed, 6 Jun 2001 10:00:40 +0900
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060610004000.00930@metukerdelong>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Enjoying the -ac2 kernel except for one minor thing: it locks up.

Problem occurs whenever large amounts of data are transferred across the 
network. This includes web pages, iso cd images, and compressed files.

I can transfer large amounts of data from the internet and to the internet 
however.

It is a hardlock, I cannot even get the SysRq key to help me out.

System specs:

P-III 550
256MB RAM (1 DIMM)
Abit SH6 (i815 based) Motherboard
Using onboard Video/Audio
Kernel 2.4.5-ac2
Debian GNU/Linux 2.2rev3
Realtek 8139B (see attached dmesg.output file)
10BaseT Network with 128K Satellite link to outside world

Tried protocols:
Samba
FTP
HTTP
NFS

If you need any more info let me know.

Thanks!

Glenn Shannon
Systems Administrator
Gibbons Enterprises Corporation, Palau
glenn@gecpalau.com
