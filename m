Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWCZAEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWCZAEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 19:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWCZAEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 19:04:51 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:2234 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751067AbWCZAEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 19:04:51 -0500
Message-ID: <4425DAA0.8050607@garzik.org>
Date: Sat, 25 Mar 2006 19:04:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Hinrich Aue <h_aue@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: promise tx2plus SATA controller and ATAPI
References: <200603251641.39064.h_aue@gmx.de>
In-Reply-To: <200603251641.39064.h_aue@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hinrich Aue wrote:
> hello there,
> 
> I purchased a promise TX2Plus SATA controller.
> Works fine so far, but I also bought a SATA DVD writer.
> The TX2Plus supports SATA ATAPI, and recognizes my burner correctly.
> But in the boot messages it says:
> 
> ata2(0): WARNING: ATAPI is not supported with this driver, device ignored.
> 
> Is there a way to use the burner with this controller?

In theory, yes.  Presently, no.


> If not, are there plans to enable ATAPI for the sata_promise driver?

Eventually, yes.

	Jeff


