Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSE1P3B>; Tue, 28 May 2002 11:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSE1P3A>; Tue, 28 May 2002 11:29:00 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:10761 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S316797AbSE1P27>; Tue, 28 May 2002 11:28:59 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256BC7.0054EC0E.00@smtpnotes.altec.com>
Date: Tue, 28 May 2002 10:10:50 -0500
Subject: 2.5.18 airo_cs unresolved symbols
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



depmod: *** Unresolved symbols in
/lib/modules/2.5.18/kernel/drivers/net/wireless/airo_cs.o
depmod:   reset_airo_card
depmod:   init_airo_card
depmod:   stop_airo_card
make: *** [_modinst_post] Error 1


