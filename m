Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUL2W7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUL2W7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUL2W7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:59:46 -0500
Received: from mail.dif.dk ([193.138.115.101]:52408 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261436AbUL2W72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:59:28 -0500
Date: Thu, 30 Dec 2004 00:10:31 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Micha <micha-1@fantasymail.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide problem...
In-Reply-To: <200412292213.34517.micha-1@fantasymail.de>
Message-ID: <Pine.LNX.4.61.0412300004090.3495@dragon.hygekrogen.localhost>
References: <200412292213.34517.micha-1@fantasymail.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Micha wrote:

> I got an error reading a dvd with 2.6.9 and ide interface. Switching to 
> ide-scsi for the dvd-rom made the dvd work. Is this an ide-error? I think 
> libdvdread should not know wether it's reading a scsi or a ide device...
> 
You are not telling us what the error message is.
You are not telling us what hardware you have.
You are not telling us anything about how your kernel is configured.
Basically you are not telling us anything.

How on earth do you expect anyone to be able to answer your question?


I'd strongly suggest you read 
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html (as well as 
the documents that document refers you to), then after you've read that 
use the suggested bugreporting form at the end and submit a new mail.
And while you are at it, take a look at http://www.tux.org/lkml/ as well.


Kind regards,
  Jesper Juhl


