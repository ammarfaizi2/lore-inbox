Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129571AbQKOLd1>; Wed, 15 Nov 2000 06:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbQKOLdS>; Wed, 15 Nov 2000 06:33:18 -0500
Received: from quechua.inka.de ([212.227.14.2]:57632 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129571AbQKOLdJ>;
	Wed, 15 Nov 2000 06:33:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NetWare Changing IP Port 524
In-Reply-To: <CDB246E6CB3@vcnet.vc.cvut.cz> <3A11A0AB.92B1109D@timpanogas.org> <20001114205629.B5133@xi.linuxpower.cx> <3A11EEF4.349E5511@timpanogas.org>
Organization: private Linux site, southern Germany
Date: Wed, 15 Nov 2000 11:33:32 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E13vzsj-00015b-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this problem is that it would give any internet hackers the ability to
> discover the network topology (including which servers host NDS master
> and replica databases).  Not very secure.  The concern for Petr is if in

If knowing the server makes it vulnerable, the server has other
problems still. Treating addresses and topology as secret is STO.

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
