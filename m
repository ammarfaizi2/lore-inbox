Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270746AbTG0Lbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270749AbTG0Lbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:31:47 -0400
Received: from lidskialf.net ([62.3.233.115]:9415 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270746AbTG0LbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:31:24 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Rahul Karnik <rahul@genebrew.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sun, 27 Jul 2003 12:46:38 +0100
User-Agent: KMail/1.5.2
Cc: Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307271222.13649.adq_dvb@lidskialf.net> <3F23BC1D.7070804@genebrew.com>
In-Reply-To: <3F23BC1D.7070804@genebrew.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271246.38338.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 12:48, Rahul Karnik wrote:
> Andrew de Quincey wrote:
> > Ah, so THATS who they licensed it from. I didn't think nividia would go
> > to the bother of designing their own ethernet hardware.
>
> Actually, this is not certain, but it is one of the guesses. So far,
> Nforce2 = AMD IDE + Intel sound + <unknown> ethernet.

It certainly loads "better" than the VIA drivers; I'd already tried hacking 
the PCI IDs into them.

