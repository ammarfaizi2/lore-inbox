Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUI0Pzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUI0Pzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUI0Pzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:55:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266538AbUI0Pxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:53:34 -0400
Date: Mon, 27 Sep 2004 11:53:27 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andreas Happe <andreashappe@flatline.ath.cx>
cc: Michal Ludvig <michal@logix.cz>, Andreas Happe <crow@old-fsckful.ath.cx>,
       <cryptoapi@lists.logix.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <20040927084149.GA3625@final-judgement.ath.cx>
Message-ID: <Xine.LNX.4.44.0409271151500.21876-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004, Andreas Happe wrote:

> just wanted to know if there's any feedback regarding this patch. It
> still applies to -rc2 without problems.

I'd like to replace /proc/crypto with this, but don't know how to do so
with the current development model.  Do we start issuing warnings (i.e.  
"this is going to disappear in one year") via printk now when someone
accesses /proc/crypto ?


- James
-- 
James Morris
<jmorris@redhat.com>


