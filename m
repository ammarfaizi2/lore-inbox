Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVBQGva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVBQGva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVBQGva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:51:30 -0500
Received: from port-83-236-181-26.static.qsc.de ([83.236.181.26]:56991 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S262243AbVBQGv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:51:28 -0500
Date: Thu, 17 Feb 2005 07:51:23 +0100
From: Robert Schwebel <robert@schwebel.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>,
       Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: recursively unregistering platform devices
Message-ID: <20050217065123.GS1722@pengutronix.de>
References: <20050206142912.GE13303@pengutronix.de> <20050216235649.GA15537@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050216235649.GA15537@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 03:56:50PM -0800, Greg KH wrote:
> Known issue, you can't recursivly register or unregister with the
> driver core right now. I'm working on fixing this issue.

Ok, great! Tell me if you have something we can test. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
