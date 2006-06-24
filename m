Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWFXIQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWFXIQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWFXIQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:16:01 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:14474 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751239AbWFXIP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:15:59 -0400
Date: Sat, 24 Jun 2006 10:09:57 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Jeff Garzik <jeff@garzik.org>, Hamish <hamish@travellingkiwi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SATA hangs...
Message-ID: <20060624100957.73fff572@localhost>
In-Reply-To: <20060624093659.7bc2a4a0@localhost>
References: <200606232134.42231.hamish@travellingkiwi.com>
	<449C6023.9010204@garzik.org>
	<20060624093659.7bc2a4a0@localhost>
X-Mailer: Sylpheed-Claws 2.3.0-rc3 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 09:36:59 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> > > I'm having problems with a SATA drive on an ASUS A8V deluxe 
> > > motherboard under kernel 2.6.17... In fact it's happened under 
> > > every (Vanilla) kernel I've ever run on this server (Back to 2.6.14).
> > > (It's just over a year old. It didn't used to experience the same load
> > > as it does now, so I'm currently assuming it's load related...
> 
> I think I've hit something similar yesterday, with 2.6.17.1...

I was thinking that I've recently enabled CONFIG_PREEMPT (usually I
was just using CONFIG_PREEMPT_VOLUNTARY).

Maybe is totally unrelated but... for Hamish: what is/was your PREEMPT
config?

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
