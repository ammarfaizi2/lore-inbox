Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWI1RCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWI1RCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWI1RCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:02:19 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:51924 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751325AbWI1RCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:02:18 -0400
Date: Thu, 28 Sep 2006 19:02:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] atmel_serial: Kill at91_register_uart_fns
Message-ID: <20060928170212.GA29691@uranus.ravnborg.org>
References: <11593762853931-git-send-email-hskinnemoen@atmel.com> <11593762851544-git-send-email-hskinnemoen@atmel.com> <11593762851494-git-send-email-hskinnemoen@atmel.com> <1159376285621-git-send-email-hskinnemoen@atmel.com> <11593762852950-git-send-email-hskinnemoen@atmel.com> <1159435315.23157.73.camel@fuzzie.sanpeople.com> <20060928113857.0e3e7c48@cad-250-152.norway.atmel.com> <1159442049.23157.94.camel@fuzzie.sanpeople.com> <20060928135131.0d075ab5@cad-250-152.norway.atmel.com> <1159444607.23157.114.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159444607.23157.114.camel@fuzzie.sanpeople.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 01:56:48PM +0200, Andrew Victor wrote:
> 
> > Rename at91_register_uart_fns and associated structs and variables
> > to make it consistent with the atmel_ prefix used by the rest of
> > the driver.
> > 
> > Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> 
> Signed-off-by: Andrew Victor <andrew@sanpeople.com>

You Sign-off a path when it passes through your hands.
You acknowledge a path by Acked-by: xxx when you acknowledge a path.

You are no the only one that get this wrong...

	Sam
