Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291394AbSB0BtB>; Tue, 26 Feb 2002 20:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291377AbSB0Bsw>; Tue, 26 Feb 2002 20:48:52 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:32552 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S291372AbSB0Bsn>; Tue, 26 Feb 2002 20:48:43 -0500
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 27 Feb 2002 02:50:26 +0100
From: Andreas Roedl <flood@flood-net.de>
In-Reply-To: <200202270026.g1R0QOa14113@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <20020227014727.811109B0D@flood-net.de>
MIME-Version: 1.0
Organization: Flood-Net
In-Reply-To: <200202270026.g1R0QOa14113@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: pcmcia problems with IDE & cardbus
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org
X-AntiVirus: OK! AvMailGate Version 6.11.0.5
	 at exciter has not found any known virus in this email.
X-Mailer: KMail [version 1.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Am Mittwoch, 27. Februar 2002 01:26 schrieb Herbert Rosmanith:

> I downloaded 2.4.18 and pcmcia-3.1.31, from the later I got "ide_cs.o"

Apart from your problem I finally found out that all dldwd_* stuff in 2.4.18 
has been renamed to orinoco_*, so pcmcia-3.1.31 is not usable with 2.4.18...



Andi

-- 
Web:   http://www.flood-net.de/
Mail:  flood@flood-net.de
Phone: +49-(0)-30-680577-44
Linux opens doors, not windows!
http://www.bundestux.de/   http://counter.li.org/
