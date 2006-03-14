Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752267AbWCNF25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbWCNF25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbWCNF24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:28:56 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:36485 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1752267AbWCNF24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:28:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [patch resend] zaurus keyboard driver updates
Date: Tue, 14 Mar 2006 00:28:54 -0500
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <1141552270.6521.5.camel@localhost.localdomain>
In-Reply-To: <1141552270.6521.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140028.54431.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 March 2006 04:51, Richard Purdie wrote:
> Zaurus keyboard driver updates:
>   * Change the scan interval from 100ms to 50ms. This stops the key 
>     repeat from triggering on double letter presses.
>   * Remove unneeded stale hinge code from corgikbd
>   * Change unneeded corgi GPIO pins to inputs when suspended
>   * Add support for the headphone jack switch for both corgi and spitz
>     (as switch SW_2)
> 
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
> 

Applied to the input tree, thank you Richard.

-- 
Dmitry
