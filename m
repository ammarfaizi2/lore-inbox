Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbUJ1FwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbUJ1FwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUJ1FwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:52:19 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:16396 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262790AbUJ1FvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:51:17 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Intel also needs convincing on firmware licensing.
Date: Thu, 28 Oct 2004 08:50:50 +0300
User-Agent: KMail/1.5.4
Cc: Han Boetes <han@mijncomputer.nl>
References: <20041028022532.GX26130@boetes.org> <200410272346.12283.gene.heskett@verizon.net>
In-Reply-To: <200410272346.12283.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410280850.51033.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 06:46, Gene Heskett wrote:
> On Wednesday 27 October 2004 22:25, Han Boetes wrote:
> >Hi,
> >
> >The people from the OpenBSD project are currently lobbying to get
> > the firmware for Intel wireless chipsets under a license suitable
> > for Open Source.
> >
> >Since this will not only benefit BSD but also the Linux Project (and
> >even Intel) I would like to mention the URL here for people who want
> > to help writing to Intel.
> >
> >  http://undeadly.org/cgi?action=article&sid=20041027193425
> >
> Please be aware that for the so-called "software radios" 
> chips/chipsets, the FCC, and other similar regulating bodies in other 
> countries has made access to the data quite restrictive in an attempt 
> to keep the less ruly among us from putting them on frequencies they 
> aren't authorized to use, or to set the power levels above whats 
> allowed.  These restrictions can vary from governing body to 
> governing body so the software is generally supplied according to 
> where the chipset is being shipped.  The potential for mischief, and 
> legal/monetary reprecussions is sufficiently great that I have 
> serious doubts that Intel will budge from their current position 
> unless we can prove, beyond any doubt, that the regulatory 
> limitations imposed will not be violated.
> 
> Since open source, where anyone who can read the code can see exactly 
> what the limits are, and 'adjust to suit', virtually guarantees 
> miss-use, sooner if not later, for no other reason than its human 
> nature to experiment, Intel/moto/etc therefore has very good reasons 
> to treat its chip<->software interface as highly secret & 
> proprietary.

However, disassemblers do exist. Hiding secrets in binary .o
files is silly.
--
vda

