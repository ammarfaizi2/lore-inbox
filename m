Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUDAQT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUDAQT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:19:26 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:40459 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262951AbUDAQTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:19:23 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Jinu M." <jinum@esntechnologies.co.in>,
       "Oliver Neukum" <oliver@neukum.org>,
       "Arjan van de Ven" <arjanv@redhat.com>
Subject: Re: Flash Media block driver problem!
Date: Thu, 1 Apr 2004 19:19:06 +0300
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A972176FD1@esnmail.esntechnologies.co.in>
In-Reply-To: <1118873EE1755348B4812EA29C55A972176FD1@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404011919.06511.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 16:07, Jinu M. wrote:
> On Thursday 01 April 2004 14:13, Oliver Neukum wrote:
> > Am Donnerstag, 1. April 2004 12:47 schrieb Jinu M.:
> > > cool; linux can use a GPL driver for such things...
> > >
> > > [jinum] guess the question/clarification is not clear!
> > > This is a driver for our own controller (PCI). Which is a PCI based
> > > card.
> > > This card is not based on the SCSI or IDE interface so how will some
> > > other driver work for it unless we write ( or get it written sharing
> > > our hardware spec) a driver for the interface?
> >
> > It will not work. A block driver must be written for such hardware to
> > make it work.
>
> Hmm, they are willing to release specs... that's good.
>
> [Jinum]
> This going way off from the original question...
>
> * NO SPECS * will be out ;)

Why? That's a good way to have driver written and debugged for free.
--
vda

