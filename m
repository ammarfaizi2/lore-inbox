Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVJEIto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVJEIto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 04:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVJEIto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 04:49:44 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:5275 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932580AbVJEItn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 04:49:43 -0400
Date: Wed, 5 Oct 2005 10:49:43 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Stephen Street <stephen@streetfiresound.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC 0/2] simple SPI controller implementation on PXA2xx SSP port
Message-ID: <20051005084943.GH24140@pengutronix.de>
References: <200510041528.17439.stephen@streetfiresound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200510041528.17439.stephen@streetfiresound.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 03:28:17PM -0700, Stephen Street wrote:
> Following this will be two patches, releasing an initial "SPI
> controller" implementation running on David Brownell's "simple SPI
> framework" and a prototype "SPI protocol" driver for the Cirrus Logic
> CS8415A SPD/IF decoder chip.  The controller should run on any PXA2xx
> SSP port and has been tested on the PXA255 NSSP port.  Complete board
> setup and description facilities per the the SPI framework are
> supported.
> 
> Your comments and suggestions encouraged!  You can e-mail me directly
> if you have any question regarding running SPI controller on your
> board.

Could you reformat this to follow the kernel coding style? 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

