Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263493AbRFANCh>; Fri, 1 Jun 2001 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263494AbRFANC1>; Fri, 1 Jun 2001 09:02:27 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:3851 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S263493AbRFANCO>;
	Fri, 1 Jun 2001 09:02:14 -0400
Date: Fri, 1 Jun 2001 15:02:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Cc: fritz@isdn4linux.de, keil@isdn4linux.de
Subject: [NEW ISDN DRIVER] TurboPAM isdn card
Message-ID: <20010601150211.A14317@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've wrote a driver for the ISDN active card TurboPAM made
by Auvertech:
	http://www.auvertech.fr

This is a card targeted at ISPs / access providers, supporting
up to 30 B-channel connections simultaneously.

The patch is available against Linux 2.4.5 and 2.2.19.

Since it is rather big, I won't post it here but just give the URL:

http://download.alcove-labs.org/software/tpam/tpam-2.4.5.patch.bz2

and

http://download.alcove-labs.org/software/tpam/tpam-2.2.19.patch.bz2

Please apply.

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|------------- Ingénieur Informatique Libre --------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|----------- Alcôve, l'informatique est libre ------------|
