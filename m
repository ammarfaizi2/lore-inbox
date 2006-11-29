Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758830AbWK2NKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758830AbWK2NKD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758831AbWK2NKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:10:01 -0500
Received: from sdcsmtp.europe.hp.net ([15.203.169.189]:1451 "EHLO
	sdcrelbas03.sdc.hp.com") by vger.kernel.org with ESMTP
	id S1758830AbWK2NKB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:10:01 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] devices.txt - LANANA merge
Date: Wed, 29 Nov 2006 14:08:02 +0100
Message-ID: <93C4769E3BED6B42B7203BD6F065654C085FE223@dmoexc01.emea.cpqcorp.net>
In-Reply-To: <456D6EE4.1070404@tls.msk.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] devices.txt - LANANA merge
thread-index: AccTqZMYAqcOJk6WQjer4k4tzDZJ1AADZ/pw
From: "Mathiasen, Torben" <Torben.Mathiasen@hp.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Nov 2006 13:10:00.0033 (UTC) FILETIME=[ACAD4D10:01C713B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +258 block	ROM/Flash read-only translation layer
> > +		  0 = /dev/blockrom0	First ROM card's 
> translation layer interface
> > +		  1 = /dev/blockrom0	Second ROM card's 
> translation layer interface
>                                   ^^^
> 
> Shouldn't here be '1', ie, /dev/blockrom1 ?
> 

Good catch. I also just added another patch fixing spelling on
lanana.org. 
I'll let this email circulate until tomorrow and then send another patch
if nothing else comes in.

Thanks,
Torben
