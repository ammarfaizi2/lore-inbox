Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbRGRSTM>; Wed, 18 Jul 2001 14:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbRGRSTE>; Wed, 18 Jul 2001 14:19:04 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:3711 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S267513AbRGRSS5>; Wed, 18 Jul 2001 14:18:57 -0400
Message-ID: <3B55D2F2.71BF34D5@pp.htv.fi>
Date: Wed, 18 Jul 2001 21:18:26 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        andre@linux-ide.org
Subject: 2.4.6-ac5 and VIA Athlon chipsets
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It looks like the 2.4.6-ac5 fixed the deadlock feature with ASUS A7V133
mobo. It's been running stable for over 24 hours now. VIA and Promise IDE
controllers are in use.

Few remaining features:

VIA IDE still misdetects 40w cable as 80w (I have also changed the cable
without effect).

HDD led stays lit regardless of disk activity (this one is new feature since
2.4.5-ac9).

Best regards,

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
