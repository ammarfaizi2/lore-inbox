Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUHMTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUHMTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUHMTav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:30:51 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:49864 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267327AbUHMT34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:29:56 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ralf Gerbig <rge-news@quengel.org>
Subject: Re: rc4-mm1 pci-routing
Date: Fri, 13 Aug 2004 13:29:30 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <200408111642.59938.bjorn.helgaas@hp.com>
In-Reply-To: <200408111642.59938.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131329.30542.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the serial I got some nice oops from wondershaper, bt878 etc. After moving the
> wonder to later stages, irgrouting works. Including ALSA and DVB with
> a Twinhan card.

I'm sorry,  I'm completely lost.  You mention an oops, but I don't
see one in the transcript you posted.

You originally mentioned a hang while alsa was starting up.  But
the transcript you posted doesn't show a hang.  Does it work when
the drivers are builtin, but hang when they are modules?

lspci shows some sort of ISDN card, but I don't see a driver for
it.  Are you using that?

Bjorn
