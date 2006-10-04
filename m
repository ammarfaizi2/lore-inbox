Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWJDTTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWJDTTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWJDTTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:19:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750846AbWJDTTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:19:10 -0400
Date: Wed, 4 Oct 2006 12:18:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Greg KH <greg@kroah.com>
Subject: Re: Industrial device driver uio/uio_*
Message-Id: <20061004121835.bb155afe.akpm@osdl.org>
In-Reply-To: <1159988394.25772.97.camel@localhost.localdomain>
References: <1157995334.23085.188.camel@localhost.localdomain>
	<1159988394.25772.97.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 19:59:54 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Llu, 2006-09-11 am 18:22 +0100, ysgrifennodd Alan Cox:
> > This passed me by while I was away so I only saw it to review in mm6. It
> > looks like it has a few problems...
> > 
> 
> And nothing has happened since [Thats Sept 11th] even on the simple bugs
> although the authors were sent a copy. At this point can the linutronix
> guys either let me know if they just never got the list of flaws or can
> we pull the drivers/uio stuff from -mm until its rather better ?
> 
> I would just NAK it but want to be sure the guys saw the list of
> problems
> 

cc's added.

Thomas has been a bit tied up with timers and interrupts of late.
