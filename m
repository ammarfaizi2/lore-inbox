Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268284AbUBRWQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUBRWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:16:50 -0500
Received: from palrel10.hp.com ([156.153.255.245]:15546 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S268284AbUBRWQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:16:48 -0500
Date: Wed, 18 Feb 2004 14:16:41 -0800
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 + hp100 -> Oops
Message-ID: <20040218221641.GA1182@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040218201559.GA31872@bougret.hpl.hp.com> <20040218124034.05c9f6aa@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218124034.05c9f6aa@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 12:40:34PM -0800, Stephen Hemminger wrote:
> 
> This should fix the problem... The multi-bus probe logic error handling was
> botched.

	Thanks. The driver now seems to works. However, the kernel
messages no longer show the device name...

	Thanks.

	Jean
