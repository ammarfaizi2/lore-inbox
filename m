Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbUEQXsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUEQXsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUEQXr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:47:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:2010 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263182AbUEQXqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:46:01 -0400
Date: Mon, 17 May 2004 16:30:14 -0700
From: Greg KH <greg@kroah.com>
To: Martin Knoblauch <knobi@knobisoft.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6.-mm3: OOPS from usbserial (?)  at boot time. Maybe preempt related
Message-ID: <20040517233014.GA22309@kroah.com>
References: <20040517191454.61971.qmail@web13905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517191454.61971.qmail@web13905.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 12:14:54PM -0700, Martin Knoblauch wrote:
> Hi,
> 
>  with 2.6.6-mm3 I get the following OOPS at boot time. Could be preempt
> related I guess. No time to check with preempt disabled right now.

No, it's my fault.  The patch already posted to lkml will fix it, sorry.

greg k-h


