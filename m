Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSFLGCw>; Wed, 12 Jun 2002 02:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSFLGCw>; Wed, 12 Jun 2002 02:02:52 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:19593 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S317636AbSFLGCv>;
	Wed, 12 Jun 2002 02:02:51 -0400
Subject: Status of FAT CVF?
From: Alan <alan@clueserver.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 11 Jun 2002 21:38:27 -0700
Message-Id: <1023856708.2934.9.camel@summanulla.clueserver.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the status of fat_cvf in 2.4.x?  Is the code abandoned?
Supported? Working? Not working? Pining for the fnords?

I have an old drive I am trying to get data off of and mounting the
compressed partition via loopback does something strange.  The mount
point shows no files, but "df" shows the correct amount for data used. 
(The compressed DriveSpace 3.x partition does contain data.)

Not urgent.  (I can get the data other ways.)  Just wanting to know how
bad it is before I start wading into the code.

Thanks!



