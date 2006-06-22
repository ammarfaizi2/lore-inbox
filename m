Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWFVK7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWFVK7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWFVK7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:59:42 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:20404 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1161056AbWFVK7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:59:42 -0400
Date: Thu, 22 Jun 2006 11:59:28 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-mips@linux-mips.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
Message-ID: <20060622105928.GA4032@linux-mips.org>
References: <20060615225723.012c82be.khali@linux-fr.org> <1150406598.1193.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150406598.1193.73.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 12:23:17AM +0300, Pete Popov wrote:

> For historical correctness, this driver was once upon a time usable,
> though it was a few years ago. It was written by MV for some ref board
> that had the ITE chip and it did work. That ref board is no longer
> around so it's probably safe to nuke the driver. 

Not quite true; the board support for that board is still around and it's
on my to-be-nuked list for after 2.6.18.

  Ralf
