Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVEPTLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVEPTLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVEPTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:11:15 -0400
Received: from mail.enyo.de ([212.9.189.167]:59803 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261627AbVEPTLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:11:12 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
References: <200505151121.36243.gene.heskett@verizon.net>
	<20050515152956.GA25143@havoc.gtf.org>
	<20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	<42877C1B.2030008@pobox.com>
	<20050516110203.GA13387@merlin.emma.line.org>
	<1116241957.6274.36.camel@laptopd505.fenrus.org>
	<20050516112956.GC13387@merlin.emma.line.org>
	<1116252157.6274.41.camel@laptopd505.fenrus.org>
	<20050516144831.GA949@merlin.emma.line.org>
	<1116256005.21388.55.camel@localhost.localdomain>
	<20050516154020.GD949@merlin.emma.line.org>
	<1116266671.21452.94.camel@localhost.localdomain>
Date: Mon, 16 May 2005 21:11:02 +0200
In-Reply-To: <1116266671.21452.94.camel@localhost.localdomain> (Alan Cox's
	message of "Mon, 16 May 2005 19:04:32 +0100")
Message-ID: <87fywn0ywp.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox:

> On Llu, 2005-05-16 at 16:40, Matthias Andree wrote:
>> On Mon, 16 May 2005, Alan Cox wrote:
>> Is tagged command queueing (we'll need the ordered tag here) compatible
>> with all SCSI adaptors that Linux supports?
>
> TCQ is a device not controller property.

I suppose it's one in RAID controllers.
