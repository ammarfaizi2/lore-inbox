Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbUDBNSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 08:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUDBNSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 08:18:07 -0500
Received: from [80.72.36.106] ([80.72.36.106]:1468 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264037AbUDBNSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 08:18:05 -0500
Date: Fri, 2 Apr 2004 15:18:01 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
In-Reply-To: <406D65FE.9090001@broadnet-mediascape.de>
Message-ID: <Pine.LNX.4.58.0404021516200.30573@alpha.polcom.net>
References: <406D65FE.9090001@broadnet-mediascape.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Olaf Zaplinski wrote:

> Hi *,
> 
> I cannot disable SCSI completely in 2.6.4's 'menuconfig'.

In default config file there is activated something under USB, what 
depends on SCSI. Try to disable that first.


Grzegorz Kulewski

