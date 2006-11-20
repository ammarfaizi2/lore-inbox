Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966846AbWKTWKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966846AbWKTWKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966842AbWKTWKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:10:33 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:41629 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S966404AbWKTWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:10:31 -0500
Subject: Re: [RFC: 2.6 patch] remove the broken SKMC driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, jejb@SteelEye.com
In-Reply-To: <20061120140115.4cdec66a@freekitty>
References: <20061120210648.GB31879@stusta.de>
	 <20061120140115.4cdec66a@freekitty>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 16:07:30 -0600
Message-Id: <1164060450.2816.103.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 14:01 -0800, Stephen Hemminger wrote:
> Are there any working microchannel drivers?

Yes: smc-mca for one.

>   Can we drop support for microchannel
> at the bus level?

No.

James


