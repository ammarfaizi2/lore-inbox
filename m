Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbSLLJGe>; Thu, 12 Dec 2002 04:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbSLLJGe>; Thu, 12 Dec 2002 04:06:34 -0500
Received: from bianet.pl ([195.116.68.1]:41379 "EHLO bianet.pl")
	by vger.kernel.org with ESMTP id <S267448AbSLLJGb>;
	Thu, 12 Dec 2002 04:06:31 -0500
Message-ID: <005b01c2a1bf$299a51c0$110011ac@home.sitech.pl>
From: "m&m's" <plachnina@bianet.pl>
To: <linux-kernel@vger.kernel.org>
Subject: aic7xxx in kernel 2.4.18
Date: Thu, 12 Dec 2002 10:16:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I'm looking for main differences between aic7xxx driver from kernel 2.4.9
and aic7xxx from kernel 2.4.18. With newer version of kernel there is a
message while system is started :
modprobe -k scsi_hostadapter errno=2
HINT : Try to change IRQ or IO settings (it sounds sth like this)

/lib/aic7xxx not found

With older version of kernel all is fine. I would like to add that scsi
driver is loading to kernel as module

Any hints?

regards
Mariusz Bozewicz

