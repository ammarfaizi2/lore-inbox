Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266935AbRGMG4h>; Fri, 13 Jul 2001 02:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbRGMG40>; Fri, 13 Jul 2001 02:56:26 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:19216 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S266935AbRGMG4U>;
	Fri, 13 Jul 2001 02:56:20 -0400
Date: Fri, 13 Jul 2001 08:56:20 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: kernel 2.4.6 compile failures in buz.c and htlmdocs
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B4E9B94.616D0AFC@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.6 , redhat 7.1 , gcc-2.96-85


Compilation of buz.c ( video grabberr stuff ) fails with some
error ( sorry , don't have it noted down ) if both Zoran chipsets
are selected as modules and "Support for IOMega Buz" is turned OFF.

and

"make htmldcos" fails at the kernel-api.sgml point.
It also fails for some other docs ( I found out by
uncommenting kernel-api from the Makefile , so it tried to
compile the next ones )


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
