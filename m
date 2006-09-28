Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWI1I2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWI1I2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWI1I2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:28:45 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:38405 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751126AbWI1I2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:28:44 -0400
Subject: Re: [PATCH 1/8] at91_serial -> atmel_serial: at91rm9200_usart.h
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <115937628584-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159431641.23154.9.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 10:20:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Move include/asm/arch/at91rm9200_usart.h into drivers/serial and rename
> it atmel_usart.h. Also delete AVR32's version of this file.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

Signed-off-by: Andrew Victor <andrew@sanpeople.com>



