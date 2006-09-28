Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWI1Jas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWI1Jas (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 05:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWI1Jas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 05:30:48 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:47621 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751804AbWI1Jar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 05:30:47 -0400
Subject: Re: [PATCH 5/8] at91_serial -> atmel_serial: Public definitions
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060928112437.5f215026@cad-250-152.norway.atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
	 <11593762853931-git-send-email-hskinnemoen@atmel.com>
	 <11593762851544-git-send-email-hskinnemoen@atmel.com>
	 <1159433643.23154.47.camel@fuzzie.sanpeople.com>
	 <20060928112437.5f215026@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159435375.23154.75.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 11:22:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Rename the following public definitions:
>   * AT91_NR_UART -> ATMEL_MAX_UART
>   * struct at91_uart_data -> struct atmel_uart_data
>   * at91_default_console_device -> atmel_default_console_device
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

Signed-off-by: Andrew Victor <andrew@sanpeople.com>



