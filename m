Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTJSWYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 18:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTJSWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 18:24:15 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:22420 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262324AbTJSWYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 18:24:07 -0400
Message-ID: <37972.192.168.9.10.1066602246.squirrel@ncircle.nullnet.fi>
In-Reply-To: <15564.1066601497@www68.gmx.net>
References: <34569.192.168.9.10.1066600317.squirrel@ncircle.nullnet.fi>
    <15564.1066601497@www68.gmx.net>
Date: Mon, 20 Oct 2003 01:24:06 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Svetoslav Slavtchev" <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Yep, but it cannot be strictly via-chipset issue
>> as I have verified that the same problem exists
>> with Epox 4PCA3+ motherboard, which is P4 & Intel 875P
>> based.
>
> may be epox got broken HPT's ?
> anyone with mainboard from other vendor seeing this problems ?

This whole thread was opened by a person with HPT rocketraid 404
PCI-card ...

>
> my HPT BIOS is v1.24
> mainboard BIOS last updated in september i think

I think I have exactly the same HPT-bios version.
The mb's bios is anyway dated 2003-03-07 so I think
we have the same version. Unfortunately, I'm unable
to check the bios version of the 875P-base mb for now
(but I think it was the same 1.24 as well).

Are you capable of trying if the hdparm -m0 trick
works for you ?

Regards,
Tomi Orava

-- 
Tomi.Orava@ncircle.nullnet.fi
