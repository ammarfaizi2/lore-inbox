Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSAIQT4>; Wed, 9 Jan 2002 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287793AbSAIQTq>; Wed, 9 Jan 2002 11:19:46 -0500
Received: from web14907.mail.yahoo.com ([216.136.225.59]:54281 "HELO
	web14907.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287786AbSAIQT2>; Wed, 9 Jan 2002 11:19:28 -0500
Message-ID: <20020109161927.23679.qmail@web14907.mail.yahoo.com>
Date: Wed, 9 Jan 2002 11:19:27 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: About Loop Device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,everyone,does anyone be familiar with the loop
device? I just read some source code of loop.c file. I
have some questions about this loop device. I am a new
one to this loop device. Thanks in advance.

I want to implement my own loop device which is used
to encrypt the whole disk,say /dev/fd0, even including
the boot sector on the floppy disk. How can I make a
connection between my own loop device with the floppy
disk? I mean how I can connect the loop device with
the floppy disk to hook the READ/WRITE operations to
the floppy disk.

Michael

______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
