Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUDANIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUDANIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:08:18 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:1803 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261238AbUDANIR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:08:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Oliver Neukum <oliver@neukum.org>, "Jinu M." <jinum@esntechnologies.co.in>,
       "Arjan van de Ven" <arjanv@redhat.com>
Subject: Re: Flash Media block driver problem!
Date: Thu, 1 Apr 2004 16:07:59 +0300
X-Mailer: KMail [version 1.4]
Cc: <linux-kernel@vger.kernel.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A972176F98@esnmail.esntechnologies.co.in> <200404011313.50530.oliver@neukum.org>
In-Reply-To: <200404011313.50530.oliver@neukum.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404011607.59087.vda@port.imtp.ilyichevsk.odessa.ua>
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
--
vda
