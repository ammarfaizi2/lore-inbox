Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUDANO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUDANO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:14:59 -0500
Received: from [202.125.86.130] ([202.125.86.130]:20143 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262900AbUDANO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:14:56 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Flash Media block driver problem!
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 1 Apr 2004 18:37:18 +0530
Message-ID: <1118873EE1755348B4812EA29C55A972176FD1@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Flash Media block driver problem!
Thread-Index: AcQX6Y1TXuSz99paSCiTON3+VR/ExQAAClIA
From: "Jinu M." <jinum@esntechnologies.co.in>
To: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Oliver Neukum" <oliver@neukum.org>,
       "Arjan van de Ven" <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 01 April 2004 14:13, Oliver Neukum wrote:
> Am Donnerstag, 1. April 2004 12:47 schrieb Jinu M.:
> > cool; linux can use a GPL driver for such things...
> >
> > [jinum] guess the question/clarification is not clear!
> > This is a driver for our own controller (PCI). Which is a PCI based
> > card.
> > This card is not based on the SCSI or IDE interface so how will some
> > other driver work for it unless we write ( or get it written sharing our
> > hardware spec) a driver for the interface?
>
> It will not work. A block driver must be written for such hardware to make
> it work.

Hmm, they are willing to release specs... that's good.

[Jinum]
This going way off from the original question...

* NO SPECS * will be out ;)

I was just trying to prove how the existing drivers will not work for our controller unless of course we release the driver we are writing :)

Guess the problem is not well framed, sorry about my English.
Someone who has worked on a block driver would answer it straight away.. 

-Jinu
