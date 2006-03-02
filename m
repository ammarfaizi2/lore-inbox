Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751994AbWCBQIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbWCBQIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbWCBQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:08:20 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:23700 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751993AbWCBQIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:08:15 -0500
Message-ID: <7080.192.54.193.25.1141315404.squirrel@rousalka.dyndns.org>
In-Reply-To: <44065C7C.6090509@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	
    <4405F471.8000602@rtr.ca>	
    <1141254762.11543.10.camel@rousalka.dyndns.org>	
    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	
    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
    <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
    <44065C7C.6090509@pobox.com>
Date: Thu, 2 Mar 2006 17:03:24 +0100 (CET)
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, "Jens Axboe" <axboe@suse.de>,
       "Tejun Heo" <htejun@gmail.com>,
       "Nicolas Mailhot" <nicolas.mailhot@gmail.com>,
       "Mark Lord" <liml@rtr.ca>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Carlos Pardo" <carlos.pardo@siliconimage.com>
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20060118.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le Jeu 2 mars 2006 03:46, Jeff Garzik a écrit :
> Eric D. Mudama wrote:

> If its 3114 I agree un-blacklisting is the way to go... but its not
> clear to me whether the problematic configuration included sata_sil or
> sata_nv.  Since I'm apparently blind :) which part of the bug points
> conclusively to sata_sil?

It's sata-sil
I'm 100% sure it's how I cabled the system
sata-nv only got a plextor drive attached
(pata-nv has two pata drives on too)


-- 
Nicolas Mailhot

