Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTH0GGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTH0GGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:06:49 -0400
Received: from 165.Red-217-126-36.pooles.rima-tde.net ([217.126.36.165]:62434
	"EHLO pau.newtral.org") by vger.kernel.org with ESMTP
	id S263156AbTH0GGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:06:47 -0400
Date: Wed, 27 Aug 2003 08:06:45 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, insecure <insecure@mail.od.ua>
Subject: Re: 2.6.0test3 + Intel 82801AA IDE + 80Gb Barracuda -> NO DMA
In-Reply-To: <200308262059.18738.insecure@mail.od.ua>
Message-ID: <Pine.LNX.4.44.0308270802540.2373-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, insecure wrote:

> On Tuesday 26 August 2003 09:57, Pau Aliagas wrote:
> > I'm having serious trouble dealing with:
> > * 80Gb Seagate Barracuda disc (Model Number ST380011A, Firmware Revision
> > 3.04) * on an Intel 82801AA IDE controller
> > * 2.6.0test3
> >
> > When booting, it disables DMA. With RH stock kernels it did not even boot.
> > It's currently running.
> 
> Does it do DMA in 2.4?

Not in RH stock kernels. And I tried up to 2.4.21-pre7 but it did not even 
boot with DMA on.

Pau


