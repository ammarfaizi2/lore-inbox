Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268413AbUHYHCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268413AbUHYHCv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUHYHCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:02:49 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:13038 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268413AbUHYHCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:02:38 -0400
Subject: Re: radeonfb problems (console blanking & acpi suspend)
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: Hamie <hamish@travellingkiwi.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <412BB8FF.3090601@travellingkiwi.com>
References: <1093277876.9973.15.camel@pro30.local.promotion-ie.de>
	 <20040824110024.GA3502@openzaurus.ucw.cz>
	 <412BB8FF.3090601@travellingkiwi.com>
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Message-Id: <1093417345.19071.13.camel@pro11.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 09:02:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 24.08.2004 schrieb Hamie um 23:54:
> Really? I use 2.6.8.1 on an r50p with radeonfb enabled, and don't 
> experience this... But I do run X as well (X.Org) with the X.Org radeon 
> driver
I use the ati-driver and that suffers from the same problem. Which X
version do you use??? I want to give it a try.

> I do have problems with a total freeze several minutes after the SECOND 
> suspend... But I'm stil trying to track that down...
I have still problems with the errors in the DSDT. Do you found any
working solution for this (I tried to modify it by the guides I found by
googling. But it didn't work for me)?

I not sure, but I think there's also a bug in the e1000 driver that
makes suspend/resume break ... do you tried to unload/load it with
acpid.

Sorry for my bad English ;-)
Alexander

