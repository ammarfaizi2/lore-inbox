Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVBPPYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVBPPYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVBPPYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:24:23 -0500
Received: from port-83-236-181-26.static.qsc.de ([83.236.181.26]:1688 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S262040AbVBPPYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:24:21 -0500
Date: Wed, 16 Feb 2005 16:24:17 +0100
From: Robert Schwebel <robert@schwebel.de>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is the purpose of GPIO pins.
Message-ID: <20050216152417.GF1722@pengutronix.de>
References: <4211E434.7060405@globaledgesoft.com> <Pine.LNX.4.61.0502150713390.9458@chaos.analogic.com> <4211E9A4.6010908@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4211E9A4.6010908@globaledgesoft.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 05:53:00PM +0530, krishna wrote:
>    NO,  Sorry I wasn't clear.
>    I am asking about GPIO controllers used in HandHeld Devices.

Embedded CPUs usually have general purpose I/O pins for all kind of
stuff; you can just use them as inputs (for example for reading
keyboards), outputs (e.g. setting LEDs) or use them as interrupt
sources with various properties (level, edge, ...). 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
