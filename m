Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTFKG7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 02:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbTFKG7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 02:59:17 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:63657 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S264158AbTFKG7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 02:59:17 -0400
Date: Wed, 11 Jun 2003 09:12:58 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: init does not run on 405GP system
Message-ID: <20030611071258.GZ9379@pengutronix.de>
References: <20030610201624.GB16103@pengutronix.de> <200306110648.h5B6m6u28632@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200306110648.h5B6m6u28632@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
X-Spam-Score: -5.0 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19Pzmu-00059g-00*BE4CnMBLI.s*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 09:53:04AM +0300, Denis Vlasenko wrote:
> I once tried to run 686 based libc on a 486, init was rained upon
> by SIGILLs 'coz it had 586+ instructions. No output on the screen
> whatsoever.

I've tried it with the DENX busybox rootimage which is definitely tested
extensively on PPC4xx, but it does not work. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
