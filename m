Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbTBYI1I>; Tue, 25 Feb 2003 03:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267849AbTBYI1I>; Tue, 25 Feb 2003 03:27:08 -0500
Received: from webmail17.rediffmail.com ([203.199.83.27]:36774 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S267843AbTBYI1H>;
	Tue, 25 Feb 2003 03:27:07 -0500
Date: 25 Feb 2003 08:36:31 -0000
Message-ID: <20030225083631.17493.qmail@webmail17.rediffmail.com>
MIME-Version: 1.0
From: "Diksha B Bhoomi" <dikshabhoomi@rediffmail.com>
Reply-To: "Diksha B Bhoomi" <dikshabhoomi@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Writing new filesystem
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am interested in writing a new filesystems. For that purpose I 
took thr src from msdos and tried to do the compiling. The 
Makefile in the msdos directory does not run. It gives the error 
that TOPDIR is not set. I set it ti /usr/src/linux so as to add 
the Rules.make but this time it gives the other errors. It 
compiles with cc and without seting the --KERNEL-- that leads to 
many errors. Now my question is that how do  I compile the code 
which I have put in /usr/src/linux/fs/myfs
the directory to hold the code for my new filesystems.

I tried to execute the make file from /usr/src/linux to create the 
new kernel but here again it does not take into account the new ly 
added dir. I then followed to make dep. In this it goes to myfs 
dir but no compiletion happens. It creates two files myfs.ver and 
myfs.ver but both of zero bytes. This means that gcc did not 
compile the code in myfs dir? What should I do now?

Diksha


Atta Dipa Bhava
