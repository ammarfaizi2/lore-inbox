Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285017AbRLKMuu>; Tue, 11 Dec 2001 07:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285019AbRLKMuk>; Tue, 11 Dec 2001 07:50:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17169 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285018AbRLKMuf>; Tue, 11 Dec 2001 07:50:35 -0500
Subject: Re: [PATCH] memory corruption in i2o
To: ncm-nospam@cantrip.org (Nathan Myers)
Date: Tue, 11 Dec 2001 12:59:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com, alan@redhat.com,
        VDA@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <20011211021032.A65086@cantrip.org> from "Nathan Myers" at Dec 11, 2001 02:10:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DmV8-0005Ky-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is typical.  The fix appears not to have been picked up in 2.4.17-pre8.
> There is no i2o maintainer listed in MAINTAINERS.
> With a 2.4.17 release candidate coming up, it's probably time to 
> apply it.

No hurry. I2O doesn't work in 2.4.16/17 anyway. If nobody elses fixes it
I'll probably take a look at it in the new year
