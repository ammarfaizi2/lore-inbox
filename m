Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSGDThI>; Thu, 4 Jul 2002 15:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSGDThI>; Thu, 4 Jul 2002 15:37:08 -0400
Received: from ua83d37hel.dial.kolumbus.fi ([62.248.234.83]:18025 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S313416AbSGDThH>; Thu, 4 Jul 2002 15:37:07 -0400
Message-ID: <3D24A475.9CD70BE0@kolumbus.fi>
Date: Thu, 04 Jul 2002 22:39:33 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [FREEZE] 2.4.19-pre10 + Promise ATA100 tx2 ver 2.20 (also with 
 Ultra133-TX2)
References: <3D14C06F.6010906@fabbione.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Massimo Di Nitto wrote:
> 
> The freeze is reproducible both with 2.4.19-pre10 and 2.4.18.

I have lockups when updatedb is running using ide-2.4.19-p7.all.convert.10
driver. Controller is Ultra133-TX2 (PDC20269) and mobo is ASUS A7M266
(AMD761 northbridge).

Memory has been checked to be OK. (48 hours of memtest86 3.0)


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

