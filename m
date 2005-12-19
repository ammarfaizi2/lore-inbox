Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVLSWuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVLSWuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 17:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVLSWuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 17:50:01 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:51881 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S965021AbVLSWuB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 17:50:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Intel e1000 fails after RAM upgrade
Date: Mon, 19 Dec 2005 16:49:58 -0600
Message-ID: <F265D57E1F28274EA189ED0566D227DE816FE7@PGJEXC01.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel e1000 fails after RAM upgrade
Thread-Index: AcYE7YcUvThPuNgcSAGS4EXU6OIYywAAFH2g
From: "Bonilla, Alejandro" <alejandro.bonilla@hp.com>
To: <c-otto@gmx.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Dec 2005 22:50:00.0338 (UTC) FILETIME=[8AC2AF20:01C604EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


|-----Original Message-----
|From: linux-kernel-owner@vger.kernel.org 
|[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Carsten Otto
|Sent: Monday, December 19, 2005 4:39 PM
|To: linux-kernel@vger.kernel.org
|Subject: Re: Intel e1000 fails after RAM upgrade
|
|On Mon, Dec 19, 2005 at 08:54:58PM +0100, Carsten Otto wrote:
|> After upgrading the memory to 4 GB I noticed my e1000 did not work.
|
|The problem also exists when I remove 2 GB. So it has to do something
|with the kernel update in between. I will downgrade the kernel 

I wish I could add something to the thread here. Sorry for not kicking
in before, I did not see it.

I remember a problem with the 100Ve and the 1000MT giving issues when it
is a LOM or even a PCI adapter. I used to fix a lot of these problems by
removing all power from the board molex, maybe the "battery" on the
mother board for some minutes and then plug-in everything back in.

Basically, the NIC wouldn't negotiate or will act funky, like no link or
no real connectivity.

Dunno if you already tried it, hope it helps.

.Alejandro

|now until
|this is solved.
|-- 
|Carsten Otto
|c-otto@gmx.de
|www.c-otto.de
|
