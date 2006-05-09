Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWEIJNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWEIJNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWEIJNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:13:23 -0400
Received: from host-84-9-217-53.bulldogdsl.com ([84.9.217.53]:7367 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932080AbWEIJNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:13:22 -0400
Date: Tue, 9 May 2006 10:10:02 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: wang_yulei@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPIO PA24 on AT91RM9200
Message-ID: <20060509091002.GA12538@home.fluff.org>
References: <10915800.1146862685034.JavaMail.websites@opensubscriber>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10915800.1146862685034.JavaMail.websites@opensubscriber>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 04:58:05AM +0800, wang_yulei@hotmail.com wrote:
> Hi,
> 
> The GPIO PA24 is Ok to be an input IO.
> But when I tried to 
> request_irq(AT91_PIN_PA24, ....)

Find the linux-arm-kernel and ask there, they will
be able to help you with this. I expect there is
not a 1:1 mapping of GPIO numbers to IRQs, but
I do not know a lot about this ARM implementation.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
