Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbUCRL1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUCRL1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:27:34 -0500
Received: from denise.shiny.it ([194.20.232.1]:34438 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262522AbUCRL1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:27:32 -0500
Date: Thu, 18 Mar 2004 12:27:28 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Samuel Rydh <samuel@ibrium.se>
cc: linux-kernel@vger.kernel.org, Micha? Roszka <michal@roszka.pl>
Subject: Re: [.config] CONFIG_THERM_WINDTUNNEL
In-Reply-To: <20040318112057.GC3686@ibrium.se>
Message-ID: <Pine.LNX.4.58.0403181221580.1392@denise.shiny.it>
References: <200403180821.44199.michal@roszka.pl>
 <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it> <20040318112057.GC3686@ibrium.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Mar 2004, Samuel Rydh wrote:

> Btw, I would like to get reports about how well this driver works
> with respect to noise reduction. I'm in particular interested
> in the dual 1.4 GHz model...

The author has a dual-1.2 and I tested it on another dual-1.2. I don't
know if it has been tested on other mathines. The driver writes in
the system logs the temperature and the fan speed every time they change,
so you can check what it's doing (and you can unload the module if you
see it does something wrong).


--
Giuliano.
