Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUHIVlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUHIVlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267252AbUHIVlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:41:39 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:63733 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266793AbUHIVk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:40:57 -0400
Message-ID: <11497362.1092087656059.JavaMail.root@ernie.psp.pas.earthlink.net>
Date: Mon, 9 Aug 2004 17:40:56 -0400 (GMT-04:00)
From: "Steven E. Woolard" <tuxq@earthlink.net>
Reply-To: "Steven E. Woolard" <tuxq@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: VFAT/MSDOS
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Earthlink Zoo Mail 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VER: 2.6.8-rc3
Using a FAT16 file system mounted via /dev/sda1 
it cannot be written to. When attempt is made it gives the error of being a read-only file system. 
This problem does not exist with 2.6.7 (confirmed)

-:=============================:-
     Steven E. Woolard
   web: http://tuxq.ath.cx
   email: tuxq@earthlink.net
   aim: tuxq
-:=============================:-
