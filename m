Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311447AbSCSQ7h>; Tue, 19 Mar 2002 11:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311450AbSCSQ71>; Tue, 19 Mar 2002 11:59:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33804 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311448AbSCSQ7V>; Tue, 19 Mar 2002 11:59:21 -0500
Subject: Re: 2.5.7 make modules_install error (oss)
To: Wayne.Brown@altec.com
Date: Tue, 19 Mar 2002 17:15:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <86256B81.005C508A.00@smtpnotes.altec.com> from "Wayne.Brown@altec.com" at Mar 19, 2002 10:48:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nNCs-0008Bc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really wish the OSS drivers would be fixed.  They worked perfectly with my
> Crystal SoundFusion card, but the ALSA drivers are very unreliable with it.
> Sometimes they work, sometimes they don't.  (One day a couple of weeks ago I

In the longer term its more productive to fix the ALSA drivers and import
any fixups they need. 2.5 is about the longer term maintainability of audio
