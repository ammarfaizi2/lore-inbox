Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262022AbRFBWyA>; Sat, 2 Jun 2001 18:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRFBWxu>; Sat, 2 Jun 2001 18:53:50 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:61063 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S262027AbRFBWxn>;
	Sat, 2 Jun 2001 18:53:43 -0400
Date: Sat, 2 Jun 2001 15:50:31 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: <linux-kernel@vger.kernel.org>
Subject: SCSI errors using USB mass storage device
Message-ID: <Pine.LNX.4.33.0106021546380.12445-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm running unmodified 2.4.5 on a Red Hat 7.1 system and have an
IBM DiskOnKey (a USB not-so-mass storage device).  When mounting the
device, the SCSI layer responds with the error:

SCSI error: host 1 id 0 lun 0 return code = 8000002
        Sense class 7, sense error 0, extended sense 0

The device seems to work fine, and I have experienced no data corruption
or other problems.  I was wondering what the cause of this error was and
if it should be taken as a warning of potential data loss.

Thanks, Ryan Mack

