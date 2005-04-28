Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVD1LZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVD1LZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVD1LZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:25:18 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:53606 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262087AbVD1LYu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:24:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cC//hCqYe9t6kyYPNGaq1uEKwgM/Jw8ACKR7xn68/CMLme+FRO7GQmsQkxC4OTHPtdvZMds2hXNrhY/NQsly3m2VruuZ437QXoEn+OwOCxDTJqcTGM8pdMNawj7wg3hgNrSHSiZjWIX+CPfpyEWZ8+cKYbMP52PDbUGKnOfAYag=
Message-ID: <21d7e99705042804245015a6b1@mail.gmail.com>
Date: Thu, 28 Apr 2005 12:24:49 +0100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Filip Zyzniewski <lkml@filip.math.uni.lodz.pl>
Subject: Re: Panic on a BIOSless machine.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4270BF52.7070807@filip.math.uni.lodz.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <426FB641.2070802@filip.math.uni.lodz.pl>
	 <Pine.LNX.4.61.0504271022460.26410@montezuma.fsmlabs.com>
	 <4270BF52.7070807@filip.math.uni.lodz.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Here it is:
> http://filip.math.uni.lodz.pl/t1000-panic/panic-without-tulip.log
> 
> Do you think memory map is wrong?

have you the kernel compiled with pci probing set to direct? or booted
with pci=nobios

Dave.
