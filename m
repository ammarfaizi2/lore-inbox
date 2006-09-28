Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWI1JLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWI1JLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWI1JLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:11:33 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:45317 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751787AbWI1JLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:11:32 -0400
Subject: Re: [PATCH 7/8] serial: Rename PORT_AT91 -> PORT_ATMEL
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1159376285621-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
	 <11593762853931-git-send-email-hskinnemoen@atmel.com>
	 <11593762851544-git-send-email-hskinnemoen@atmel.com>
	 <11593762851494-git-send-email-hskinnemoen@atmel.com>
	 <1159376285621-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159434216.23157.54.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 11:03:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The at91_serial driver can be used with both AT32 and AT91 devices
> from Atmel and has therefore been renamed atmel_serial. The only
> thing left is to rename PORT_AT91 PORT_ATMEL.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

Signed-off-by: Andrew Victor <andrew@sanpeople.com>



