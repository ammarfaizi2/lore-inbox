Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTFOTgD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTFOTgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:36:03 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:11470 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S262813AbTFOTgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:36:01 -0400
Date: Sun, 15 Jun 2003 15:49:37 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
cc: linux-kernel@vger.kernel.org
Subject: linux-2.4.21 released ,  No changelog for sym53c8xx_2 mods ?
In-Reply-To: <200306131453.h5DErX47015940@hera.kernel.org>
Message-ID: <Pine.LNX.4.56.0306151540080.13925@filesrv1.baby-dragons.com>
References: <200306131453.h5DErX47015940@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Marcello ,  I have a problem with the lack of changelog
	entries concerning the sym53c8xx_2 driver .  There are none .
	And yet there has been changes to the driver tree .
	As you'll note this includes the change log file in the driver
	tree as well .  I have grep'd and manually viewed the change logs
	from kernel.org with no mention of these changes noted .

	Also Mr. Roudier put out a patch set versioned sym-2.1.19-pre3 on
	20031123 which has never been insterted into 2.4 (possibly at his
	request) .  I have been using this patch since the above date
	without difficulty in every pre ,  rc & release since that date .
		Tia ,  JimL

   8 -rw-r--r--    1 573      573          6015 Dec 21  2001 ChangeLog.txt
  12 -rw-r--r--    1 573      573         10274 Nov 28  2002 sym_malloc.c
  76 -rw-r--r--    1 573      573         73259 Nov 28  2002 sym_glue.c
  60 -rw-r--r--    1 573      573         53467 Nov 28  2002 sym_fw2.h
  48 -rw-r--r--    1 573      573         48334 Nov 28  2002 sym_fw1.h
  12 -rw-r--r--    1 573      573         10424 Nov 28  2002 sym53c8xx.h
 152 -rw-r--r--    1 573      573        149323 Jun 13 10:51 sym_hipd.c
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
