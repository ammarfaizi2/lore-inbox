Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751860AbWI1MEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbWI1MEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 08:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWI1MEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 08:04:42 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:54533 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751860AbWI1MEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 08:04:42 -0400
Subject: Re: [PATCH 8/8] atmel_serial: Kill at91_register_uart_fns
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060928135131.0d075ab5@cad-250-152.norway.atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
	 <11593762853931-git-send-email-hskinnemoen@atmel.com>
	 <11593762851544-git-send-email-hskinnemoen@atmel.com>
	 <11593762851494-git-send-email-hskinnemoen@atmel.com>
	 <1159376285621-git-send-email-hskinnemoen@atmel.com>
	 <11593762852950-git-send-email-hskinnemoen@atmel.com>
	 <1159435315.23157.73.camel@fuzzie.sanpeople.com>
	 <20060928113857.0e3e7c48@cad-250-152.norway.atmel.com>
	 <1159442049.23157.94.camel@fuzzie.sanpeople.com>
	 <20060928135131.0d075ab5@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159444607.23157.114.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 13:56:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Rename at91_register_uart_fns and associated structs and variables
> to make it consistent with the atmel_ prefix used by the rest of
> the driver.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

Signed-off-by: Andrew Victor <andrew@sanpeople.com>



