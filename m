Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265155AbUFHBxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUFHBxO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 21:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUFHBxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 21:53:14 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:9479 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265155AbUFHBxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 21:53:13 -0400
Date: Tue, 8 Jun 2004 03:53:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Tony Lill <ajlill@ajlc.waterloo.on.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 broke lilo somehow
Message-ID: <20040608015310.GA6479@pclin040.win.tue.nl>
References: <200406061740.i56HevLR009432@freevo.ajlc.waterloo.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406061740.i56HevLR009432@freevo.ajlc.waterloo.on.ca>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 01:40:57PM -0400, Tony Lill wrote:

> I upgraded one of my boxes, and old Tyan Tiger 100 dual CPU box from
> 2.4.23 to 2.6.5, and for some reason, when I run lilo under 2.6.5, it
> doesn't work right. WHen I reboot, all I get is LI

Have you tried giving lilo the "linear" or "lba32" option?
