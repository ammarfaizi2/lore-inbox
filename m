Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317384AbSGDJyY>; Thu, 4 Jul 2002 05:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSGDJyY>; Thu, 4 Jul 2002 05:54:24 -0400
Received: from 89dyn229.com21.casema.net ([62.234.20.229]:62435 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S317384AbSGDJyX>; Thu, 4 Jul 2002 05:54:23 -0400
Message-Id: <200207040955.LAA04557@cave.bitwizard.nl>
Subject: Re: EXT3-fs error on kernel 2.4.18-pre3
In-Reply-To: <1025723138.3817.10.camel@storm.christs.cam.ac.uk> from Anton Altaparmakov
 at "Jul 3, 2002 08:05:38 pm"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Thu, 4 Jul 2002 11:55:57 +0200 (MEST)
CC: sct@redhat.com, Andrew Morton <akpm@zip.com.au>, adilger@turbolinux.com,
       LKML <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> EXT3-fs error (device md(9,4)): ext3_free_blocks: Freeing blocks not in
> datazone - block = 33554432, count = 1 

I thought I'd try to beat Andries to noting this: That's 0x2000000!
:-)

			Rogier. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
