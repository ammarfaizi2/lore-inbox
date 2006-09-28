Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWI1I6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWI1I6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWI1I6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:58:38 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:42501 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1751796AbWI1I6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:58:37 -0400
Subject: Re: [PATCH 3/8] at91_serial -> atmel_serial: Kconfig symbols
From: Andrew Victor <andrew@sanpeople.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060928105436.73aeb23d@cad-250-152.norway.atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	 <115937628584-git-send-email-hskinnemoen@atmel.com>
	 <11593762852168-git-send-email-hskinnemoen@atmel.com>
	 <11593762851735-git-send-email-hskinnemoen@atmel.com>
	 <1159432488.23157.25.camel@fuzzie.sanpeople.com>
	 <20060928105436.73aeb23d@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159433444.23157.42.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Sep 2006 10:50:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Haavard,

> Right. Probably shouldn't have changed the prompt -- I have a different
> patch that actually adds AVR32 support (I don't want to do that before
> it actually compiles on AVR32, in case some crazy person comes along
> and tries out allyesconfig ;)
> 
> Is it OK if I keep the patch as it is and change the dependency and
> help text in a later patch?

That's would be fine - the current patch won't affect the AT91 support.

Signed-off-by: Andrew Victor <andrew@sanpeople.com>


Regards,
  Andrew Victor


