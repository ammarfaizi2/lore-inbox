Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSJYFvr>; Fri, 25 Oct 2002 01:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSJYFvr>; Fri, 25 Oct 2002 01:51:47 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33555 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261205AbSJYFvq>; Fri, 25 Oct 2002 01:51:46 -0400
Message-Id: <200210250553.g9P5r0p13717@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: EISA AIC7XXX not detected
Date: Fri, 25 Oct 2002 08:45:32 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200210231448.g9NEmJp04017@Port.imtp.ilyichevsk.odessa.ua> <200210240920.g9O9KDp08623@Port.imtp.ilyichevsk.odessa.ua> <2389302704.1035478475@aslan.scsiguy.com>
In-Reply-To: <2389302704.1035478475@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 October 2002 14:54, Justin T. Gibbs wrote:
> > With this patch it got detected. Seems to work fine.
> > Please inform me when (and whether) you plan to push it
> > to Marcelo.
> >
> > (of course feel free to edit the patch, I don't insist on 'vda'
> > being there :)
>
> Can you send me the chip markings on your controller as well as any
> information that it affixed to the controller board (Stickers with
> model numbers, etc)?

This board is not very big.

Biggest chip has this printed on:
adaptec
AIC-7770P
EQEA440
711211
A48061.1
KOREA

Second big chip has a rather uninformative sticker with letters "PD2U"
slapped on so I can't see what is printed on chip :(

This text is printed on the back side of the board:
"(c) OLIVETTI,1994 G0622C COD.794126L /00 B-S-C4

There is a barcode printed on a side, do you need it? :)

Also I see at least 3 SCSI connectors. One on a side, accessible
from the rear of the box when board sits in EISA slot.
Two connectors are on the top side (opposite to EISA bus connector).
And I see something like 2 more SCSI connectors right
on the board surface.

This box is accompanied with configuration diskettes, I'll send 'em
to you off-list.
--
vda
from those attached.
