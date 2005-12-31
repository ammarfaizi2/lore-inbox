Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVLaIrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVLaIrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 03:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVLaIrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 03:47:21 -0500
Received: from mta1.srv.hcvlny.cv.net ([167.206.4.196]:32230 "EHLO
	mta1.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751321AbVLaIrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 03:47:20 -0500
Date: Sat, 31 Dec 2005 03:47:19 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Integer types
To: linux-kernel@vger.kernel.org
Message-id: <20051231084719.GA6702@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the prefered integer type for kernel code?

* u8, u16, ...
* uint8_t, uint16_t, ...
* u_int8_t, t_int16_t, ...

Thanks,
Josef "Jeff" Sipek.
