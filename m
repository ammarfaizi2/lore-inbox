Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281672AbRKQBas>; Fri, 16 Nov 2001 20:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281673AbRKQBah>; Fri, 16 Nov 2001 20:30:37 -0500
Received: from tan7.ncr.com ([192.127.94.7]:47125 "EHLO
	susdayte51.daytonoh.ncr.com") by vger.kernel.org with ESMTP
	id <S281672AbRKQBa3>; Fri, 16 Nov 2001 20:30:29 -0500
Message-ID: <61A60D883863D411A36600D0B785B50C06D5FEA4@susdayte51.daytonoh.ncr.com>
From: "Pinyowattayakorn, Naris" <np151003@exchange.SanDiegoCA.NCR.COM>
To: linux-kernel@vger.kernel.org
Subject: Driver callback routine when panic() is called
Date: Fri, 16 Nov 2001 20:30:23 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I don't know if this is an appropriate question to ask on this mailing list
but I have no idea where to ask. 

Is there any call that can be used for a driver to register system crash
callback routines. Thus, If panic( ) is called, such a callback can save
device-state information to be written into the system crash dump file. 

Thanks,
Naris
