Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVLULtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVLULtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVLULtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:49:24 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:41186 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S932380AbVLULtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:49:24 -0500
Date: Wed, 21 Dec 2005 12:50:09 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Ivan Korzakow <ivan.korzakow@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPIO device class driver
Message-ID: <20051221115009.GZ6703@pengutronix.de>
References: <a59861030512210307l4c8a0a29o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a59861030512210307l4c8a0a29o@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan, 

On Wed, Dec 21, 2005 at 12:07:27PM +0100, Ivan Korzakow wrote:
> I read about a generic device class driver (http://marc.theaimsgroup.com/?l=
> linux-kernel&m=109419719600753&w=2) for GPIO. I wanted to know if anything
> generic finally came out of the dicussion ?
> I'm willing to write a gpio driver and I am considering taking Robert Schwebel
> patch into it if nothing exist in the main line.

As far as I know there is nothing new available yet; the LED framework
people have don some things, but it should be "above" GPIO. This morning
we have discussed serveral things which could be improved in our code;
if you are interested I'll keep you informed about the progress. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9

