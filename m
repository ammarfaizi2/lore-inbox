Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265144AbSKESkT>; Tue, 5 Nov 2002 13:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265150AbSKESkT>; Tue, 5 Nov 2002 13:40:19 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:21950 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265144AbSKESkS>; Tue, 5 Nov 2002 13:40:18 -0500
Message-Id: <4.3.2.7.2.20021105193436.00b4dcb0@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 05 Nov 2002 19:47:02 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: U160 on Adaptec 39160
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Re: Anybody know why I'm not getting 160MB transfers ?
	It might interest people to know the end story -
	After much fiddling around with cables/terminators, banning
	the SCSI-2 devices(DVD + DAT) to their own adapter and updating
	every piece of BIOS firmware in sight, I was still getting nowhere.
	So, (deep think) I threw a vanilla 2.4.19 onto the machine and
	LO and BEHOLD, I'm getting 160MB transfers!
	Well (hope Dave Jones is listening!,), it seems as though
	the Suse 8.1 kernel 2.4.19 has (yet another) problem.

	Cheers

	Margit Schubert-While

