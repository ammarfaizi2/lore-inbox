Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271772AbTGRPGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271822AbTGRPFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:05:23 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:25094 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271761AbTGROtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:49:06 -0400
Date: Fri, 18 Jul 2003 17:04:00 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, alan@lxorguk.ukuu.org.uk,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH: typo bits
Message-ID: <20030718170400.A3094@pclin040.win.tue.nl>
References: <Pine.GSO.4.21.0307181221390.22944-100000@vervain.sonytel.be> <1058528165.19558.3.camel@dhcp22.swansea.linux.org.uk> <20030718152947.B3019@pclin040.win.tue.nl> <20030718073319.37d7863f.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030718073319.37d7863f.rddunlap@osdl.org>; from rddunlap@osdl.org on Fri, Jul 18, 2003 at 07:33:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 07:33:19AM -0700, Randy.Dunlap wrote:

> | Isosynchronous is (was?) not an English word.
> | 
> | Oh, but we aren't speaking English - this is about USB devices.
> | Read the USB standard and see that it has an isosynchronous mode.
> 
> It does?  I can't find it in the main USB 2.0 spec.
> It discusses isochronous, which is what I would prefer to see,
> regardless of the USB spec.

Ah, yes, you are right. I did a grep on the USB docs directory
and it is full of isosynchronous, but those are all fragments
from the net. The actual standards correctly use isochronous.
Sorry.

Andries

