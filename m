Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbREaSjK>; Thu, 31 May 2001 14:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbREaSjA>; Thu, 31 May 2001 14:39:00 -0400
Received: from mustart.heime.net ([194.234.65.222]:4 "EHLO mustard.heime.net")
	by vger.kernel.org with ESMTP id <S263151AbREaSir>;
	Thu, 31 May 2001 14:38:47 -0400
Date: Thu, 31 May 2001 20:38:48 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: union mounting file systems...
Message-ID: <Pine.LNX.4.30.0105312033380.1184-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I just read the "Wonderful world of linux (2.4)", where it's said that the
Linux kernel 2.4 supports so-called union mounted file systems. I recently
downloaded the RedHat 7.1 distribution and loop-back mounted the CD's to
be able to install over ftp, but no... RedHat's install script reminds me
of all the flexibility you can get from an installer delivered from
Microsoft. After installing the stuff from CD #1, you're _not_ asked where
CD #2 is supposed to be; you just get loads of error messages on the
console. So - I can copy all the files from the two CD's - or - union
mount them (the .iso's) on a common directory.

Does anyone know where I can find a mount program that actually does this?

Please cc: to me, as I'm not on the list

regards

roy

