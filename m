Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSLZENI>; Wed, 25 Dec 2002 23:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSLZENI>; Wed, 25 Dec 2002 23:13:08 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:21720 "EHLO
	host.ehost4u.biz") by vger.kernel.org with ESMTP id <S262360AbSLZENH>;
	Wed, 25 Dec 2002 23:13:07 -0500
From: "Billy Rose" <billyrose@billyrose.net>
To: user@mail.econolodgetulsa.com
CC: bp@dynastytech.com, linux-kernel@vger.kernel.org, felipewd@terra.com.br
Reply-To: billyrose@billyrose.net
Subject: Re: CPU failures ... or something else ?
X-Mailer: NeoMail 1.25
X-IPAddress: 65.132.64.212
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E18RPWN-0001xf-00@host.ehost4u.biz>
Date: Wed, 25 Dec 2002 23:21:23 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.ehost4u.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32076 2072] / [32076 2072]
X-AntiAbuse: Sender Address Domain - host.ehost4u.biz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Understood.  Thank you for that diagnosis.
>
>
> usually it says proc #1 in the error, but the first time it said proc
> #0 - is that interesting ?

youre welcome :)

if youre hanging on to that box, remove the memory from banks 3 and 4
and it should be ok. if my memory serves me right, you cant have only 3
banks of memory (hence removing bank 3 also), the motherboard is
configured to handle 1, 2, or 4 populated banks. it you leave bank 3
in while removing bank 4, it will beep at you when you power it on and
do nothing. with a gig of ram, it should still be plenty useful.

billy
=====
"there's some milk in the fridge that's about to go bad...
and there it goes..." -bobby
