Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284566AbRLES7g>; Wed, 5 Dec 2001 13:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284574AbRLES71>; Wed, 5 Dec 2001 13:59:27 -0500
Received: from HETZMANNSEDER.inst-4.ufg.ac.at ([193.170.97.254]:2579 "EHLO
	hetzmannseder.inst-4.ufg.ac.at") by vger.kernel.org with ESMTP
	id <S284575AbRLES7R>; Wed, 5 Dec 2001 13:59:17 -0500
Date: Wed, 5 Dec 2001 19:59:06 +0100 (CET)
From: Markus Hetzmannseder <hetzi@hetzi.at>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 apm+cdrom problem
Message-ID: <Pine.LNX.4.40.0112051652480.18560-100000@hetzmannseder.inst-4.ufg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my notebook is a Gericom Hydrospeed with AMD-K6-2 and VT82CXXX Chipset.

The notebook produces a complete system hangup if I use the cd-drive, make
apm --suspend and by the next cdrom usage its frozen. There is no
error-message oder something else.

You can find my kernel config under
http://www.hetzi.at/hetzi/config-gericom-2.4.16

Under 2.4.14 and other kernels before was no such hangup.

Thanks

Hetzmannseder Markus 				http://www.hetzi.at/hetzi/
--------------------------------------------------------------------------
It is a hard matter, my fellow citizens, to argue with the belly, since it
has no ears.
		-- Marcus Porcius Cato



