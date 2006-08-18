Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWHRLYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWHRLYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWHRLYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:24:12 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:14949 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932422AbWHRLYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:24:10 -0400
Date: Fri, 18 Aug 2006 15:23:46 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: jean-paul.saman@philips.com, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, vitalywool@gmail.com
Subject: Re: ip3106_uart oddity
Message-Id: <20060818152346.b1d4c7f3.vwool@ru.mvista.com>
In-Reply-To: <20060818082756.GB6901@flint.arm.linux.org.uk>
References: <20060817202954.GC28474@flint.arm.linux.org.uk>
	<OF21337E37.31820A4F-ONC12571CE.002682FD-C12571CE.002AB6EB@philips.com>
	<20060818082756.GB6901@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 09:27:56 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:
 
> There are no plans what so ever to "restore" what was never even there.
> Searching around, there was a pnx0105 driver submitted but needed some
> additional work which was never done.

pnx0105's uart fits well into 8250 concept, so I don't think it will ever show up.
 
> The same situation seems to apply to this driver.  Ralf submitted a
> driver called ip3106_uart.c which claimed to be a rewrite of
> pnx8550_uart.c.  Comments were given at that time, no real feedback
> came of that.

Is it possbile that you include comments in the reply to this message? TIA! :)

Vitaly
