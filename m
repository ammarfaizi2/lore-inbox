Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132731AbRDOVn5>; Sun, 15 Apr 2001 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132802AbRDOVns>; Sun, 15 Apr 2001 17:43:48 -0400
Received: from mail2.rdc2.ab.home.com ([24.64.2.49]:62352 "EHLO
	mail2.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S132731AbRDOVni>; Sun, 15 Apr 2001 17:43:38 -0400
Message-ID: <3ADB167D.3872BB38@home.com>
Date: Mon, 16 Apr 2001 09:57:49 -0600
From: "Matthew W. Lowe" <swds.mlowe@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.3.4 Module Problems UPDATED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've gotten both NICs to work thanks to the help from you guys.
Basically, what you have to do is disable all the packet filtering stuff
with exception to the minimal requirements to select ipchains. And also
I disabled modular install and built in install for every nic card but
the ones I had. (aka, clicking a bunch of options, rebooting and linux
loading.)

Note: Just in case anyone else comes around asking about 2000 smbfs
mounting, it works with 2.4.3. Before (or in version 2.2.16 and
earlier... Not sure when it was fixed) there use to be this bug with
mounting 2000 shares. Changes to the drive and files wouldn't be
updated, just reloaded from the cache.

Thanks for the help,
   Matt

