Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVCSQfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVCSQfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 11:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVCSQfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 11:35:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50699 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262638AbVCSQfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 11:35:21 -0500
Date: Sat, 19 Mar 2005 16:35:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][1/6] Secure Digital (SD) support : protocol
Message-ID: <20050319163500.B23907@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
	Richard Purdie <rpurdie@rpsys.net>
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx> <422A5EBD.3050307@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <422A5EBD.3050307@drzeus.cx>; from drzeus-list@drzeus.cx on Sun, Mar 06, 2005 at 02:37:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 02:37:01AM +0100, Pierre Ossman wrote:
> Protocol definitions.
> 
> The basic commands needed for the later patches. The R1_APP_CMD seems to 
> be misdefined in protocol.h so this patch changes it.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
