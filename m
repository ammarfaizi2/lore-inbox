Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272864AbTG3NAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272871AbTG3NAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:00:22 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:9733 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272864AbTG3NAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:00:18 -0400
Date: Wed, 30 Jul 2003 15:00:15 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: CaT <cat@zip.com.au>
Cc: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730130015.GA2507@win.tue.nl>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk> <20030730063657.GH1395@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730063657.GH1395@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 04:36:57PM +1000, CaT wrote:

> Would this (now or in the future) by any chance let one use the keyboard
> leds for stuff without activating their num lock, caps lock and scroll
> lock functionality? I'd like to use one of them (at least) as a network
> traffic indicator but so far I get the sideffects of the functionality
> being on also. Most annoying when typing. :/

The use of LEDs as random lights instead of as keyboard status indicators
has been possible since very early times. See the kernel code, or setleds(1).

