Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbTK3DmP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 22:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTK3DmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 22:42:15 -0500
Received: from [212.102.131.179] ([212.102.131.179]:29668 "EHLO acs.vm")
	by vger.kernel.org with ESMTP id S264600AbTK3DmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 22:42:12 -0500
Message-ID: <33477.195.252.80.131.1070163725.squirrel@mail.transacty.co.yu>
In-Reply-To: <1070125010.3972.2.camel@zeus.fullmotionsolutions.com>
References: <1070125010.3972.2.camel@zeus.fullmotionsolutions.com>
Date: Sun, 30 Nov 2003 04:42:05 +0100 (CET)
Subject: Re: i875p
From: "Zoran Davidovac" <zoran.davidovac@transacty.co.yu>
To: "Danny Brow" <fms@istop.com>
Cc: "Kernel-Maillist" <linux-kernel@vger.kernel.org>
Reply-To: zoran.davidovac@transacty.co.yu
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there going to be support for the i875p chipset in 2.4.24? I can't
> load agpgart with 2.4.23, nor with 2..4.22.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

it works without problem if you append in lilo

 append="agp=try_unsupported"

(tested on 2.4.22 & 2.4.23)

Nice Playing.

