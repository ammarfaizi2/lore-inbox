Return-Path: <linux-kernel-owner+w=401wt.eu-S1752334AbWLVTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbWLVTb3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbWLVTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:31:29 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:23106 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752326AbWLVTb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:31:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=or19lULKhmxLmSMbXHuRLGc+B4u6vdLyYlMhwnQZxz908xZtTqEbedxken+ORPVLOnUZroq0MjGsYe/egPoo8x/HthlX+/aWcPTXdM6JVvkRx0C+vKXhom9oy2aBTBjIwrxRm03NHaau0VY7jS8GOqkQ0d4ukXjQpY0iYNs1jis=  ;
X-YMail-OSG: uJb6yHIVM1n2MhbTq_9hWNWLEqT9OIyhMSbf4u2I2bG4rFdUUPIycHDSoAJW4WfyS0wr8.KRdWIcMTjIRSNLNTgRTPjtiPRO2dz7X35q4Dk7agRsEczXkq6febg.Bjb9390Bnk_WCWuDymufGbMfi0NRl._3cKDCHQObJLcLXTkQFP9446s3Z4JS5RXr
From: David Brownell <david-b@pacbell.net>
To: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
Date: Fri, 22 Dec 2006 11:31:25 -0800
User-Agent: KMail/1.7.1
Cc: Dmitry Torokhov <dtor@mail.ru>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrice Vilchez <patrice.vilchez@rfo.atmel.com>
References: <4582BD29.4020203@rfo.atmel.com> <200612201513.09705.david-b@pacbell.net> <458A875D.3000801@rfo.atmel.com>
In-Reply-To: <458A875D.3000801@rfo.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612221131.25858.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 December 2006 5:08 am, Nicolas Ferre wrote:
 
> > Let me try to sort out the mess with those updates, and ask you to refresh
> > this ads7843 support against that more-current ads7846 code.
> 
> Ok, let me know when you have a newer code. I will try to adapt my
> ads7843 support then.

I just sent these updates to LKML ... though the address I had for Dmitry
sees to have gone bad, I do see all six patches in the list archives.

Now it's your turn.  :)

- Dave
