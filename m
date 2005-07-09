Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVGISey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVGISey (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVGISey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:34:54 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:52140 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261685AbVGISdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:33:52 -0400
X-ORBL: [63.202.173.158]
Date: Sat, 9 Jul 2005 11:33:37 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, azarah@nosferatu.za.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050709183337.GA16314@taniwha.stupidest.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <1120933916.3176.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120933916.3176.57.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 08:31:55PM +0200, Arjan van de Ven wrote:

> it's a config option. Some distros ship 100 already, others 1000,
> again others will do 250.

Who does anything other than 1000 for a 2.6.x kernel?
