Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264874AbUFLQpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUFLQpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUFLQpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 12:45:39 -0400
Received: from dave.clendenan.ca ([142.179.66.169]:18634 "EHLO
	dave.clendenan.ca") by vger.kernel.org with ESMTP id S264874AbUFLQpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 12:45:38 -0400
Date: Sat, 12 Jun 2004 09:45:34 -0700
From: Dave Clendenan <dave@dave.clendenan.ca>
To: support@stallion.oz.au, support@stallion.com
Cc: linux-kernel@vger.kernel.org
Subject: error in linux kernel source file istallion.c
Message-ID: <20040612164533.GA11125@dave.clendenan.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Very minor bug - printk with two '%d's and one int to print out.

Lines 853-854 of drivers/char/istallion.c (kernel 2.6.6)
Code is an error message 'failed to un-register tty driver'


CC-ing the kenel list, since the manufacturer of the device
that driver's for has changed hands, and the maintainer of
the driver (if any :) may not be reachable at the 'support'
addresses above.  


Dave

