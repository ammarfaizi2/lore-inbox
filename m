Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVINJzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVINJzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVINJzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:55:54 -0400
Received: from albireo.ucw.cz ([84.242.65.108]:52664 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S965127AbVINJzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:55:54 -0400
Date: Wed, 14 Sep 2005 11:55:48 +0200
From: Martin Mares <mj@ucw.cz>
To: Pascal Bellard <pascal.bellard@ads-lu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Frank Sorenson <frank@tuxrocks.com>,
       riley@williams.name, linux-kernel@vger.kernel.org
Subject: Re: [i386 BOOT CODE] kernel bootable again
Message-ID: <20050914095548.GA5831@ucw.cz>
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192> <432722A1.8030302@tuxrocks.com> <43272B9D.1030301@zytor.com> <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Now two solutions:
> 
> - without this patch = linux kernel are never directly bootable
> - with this patch = linux kernel is directly bootable with some
>   devices.
> 
> What is the better idea ?

The first, as long as nobody really needs direct booting. Code bloat.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The first myth of management is that it exists.
