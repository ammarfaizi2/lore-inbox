Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTIWRyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTIWRyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:54:52 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29710 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262128AbTIWRyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:54:51 -0400
Date: Tue, 23 Sep 2003 19:54:49 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suid bit behaviour modification in 2.6.0-test5
Message-ID: <20030923195449.A1572@pclin040.win.tue.nl>
References: <3F6CF491.9030205@free.fr> <200309220425.21862.lkml@ordinal.freeserve.co.uk> <bkpuur$e63$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <bkpuur$e63$1@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Sep 23, 2003 at 05:12:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 05:12:59PM +0000, bill davidsen wrote:

> Well, if ls gets that bit as still set, what would happen if someone
> actually ran the program before the sync was done? COuld the file be
> modified and then run? Is there a window? Still smells bugish.

I don't know why you people continue the debate - is anything wrong
with the fix I sent?

