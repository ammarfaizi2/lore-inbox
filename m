Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264311AbRFHVWo>; Fri, 8 Jun 2001 17:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264322AbRFHVWf>; Fri, 8 Jun 2001 17:22:35 -0400
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:29714 "HELO
	mail.clusterfilesystem.com") by vger.kernel.org with SMTP
	id <S264311AbRFHVWT>; Fri, 8 Jun 2001 17:22:19 -0400
Date: Fri, 8 Jun 2001 15:23:16 -0600 (MDT)
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: <linux-kernel@vger.kernel.org>
Subject: Ext3 kernel RPMS (2.4.5 & 2.2.19)
Message-ID: <Pine.LNX.4.33.0106081522340.1388-100000@lustre.clusterfilesystem.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mostly for my own use, I prepared two kernel RPM's with Ext3 in them.

They are totally basic:  kernel + ext3 patch, config based on Red Hat
i386-smp config files.  They include an RPM for e2fsprogs based on
Stephen's code.

I am running them (very) happily.

Versions:
2.2.19 + 0.0.7a
2.4.5  + 0.0.6

PLEASE USE THESE AT YOUR OWN RISK - THEY CONTAIN EXPERIMENTAL FILE SYSTEM
CODE.

The RPMS's can be found at:

ftp://ftp.clusterfilesystem.com/pub/ext3

Have a good day!

- Peter J. Braam -
http://www.clusterfilesystem.com



