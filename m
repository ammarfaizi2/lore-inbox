Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265484AbUF2F5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265484AbUF2F5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 01:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUF2F5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 01:57:39 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:28095 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265484AbUF2F5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 01:57:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] driver model and sysfs support for PCMCIA (1/3)
Date: Tue, 29 Jun 2004 00:57:34 -0500
User-Agent: KMail/1.6.2
Cc: Adam Belay <ambx1@neo.rr.com>, rmk@arm.linux.org.uk,
       linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       greg@kroah.com
References: <20040628200224.GE5175@neo.rr.com>
In-Reply-To: <20040628200224.GE5175@neo.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406290057.35329.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 June 2004 03:02 pm, Adam Belay wrote:
> Hi,
> 
> This patch updates the pcmcia subsystem to utilize the driver model and sysfs.
> It cooperates peacefully with pcmcia-cs and does not break any drivers or
> require any API changes.  It has been tested and is stable on my boxes.
>

Works nicely here with SMC 2632W-v2 wireless card (atmel-cs) and

02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller 

-- 
Dmitry
