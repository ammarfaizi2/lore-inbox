Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292308AbSBPBYW>; Fri, 15 Feb 2002 20:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292310AbSBPBYL>; Fri, 15 Feb 2002 20:24:11 -0500
Received: from air-2.osdl.org ([65.201.151.6]:17170 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292308AbSBPBYC>;
	Fri, 15 Feb 2002 20:24:02 -0500
Date: Fri, 15 Feb 2002 17:18:54 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] new VFS documentation
In-Reply-To: <Pine.GSO.4.21.0202142246020.23441-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33L2.0202151712220.11494-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Alexander Viro wrote:

| 	First of all, since 2.5.5-pre1 there is an up-to-date guide for
| porting filesystems from 2.4 to 2.5.<latest>.  Location:
|
| 	Documentation/filesystems/porting
|
| It WILL be kept up-to-date.  IOW, submit an API change that may require
| filesystem changes without a corresponding patch to that file and I will
| hunt you down and hurt you.  Badly.
|
| New locking scheme is described in Documentation/filesystems/directory-locking.
| In details and with proof of correctness.
|
| Documentation/filesystems/Locking is slowly getting up-to-date.  Descriptions
| of several superblock methods are still missing and I would really appreciate
| it if folks who had introduced them would document them.

Way to go, Al!

Anyone:
Are there any linux-filesystem-like web pages, sorta like what
Rik has for MM/VM?

Here's a beginning, if someone would like to use it or add to it:

  http://www.osdl.org/archive/rddunlap/linux-fs.html

-- 
~Randy

