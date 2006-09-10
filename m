Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWIJWYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWIJWYx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWIJWYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:24:52 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:15325 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932113AbWIJWYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:24:51 -0400
Date: Mon, 11 Sep 2006 00:21:09 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Misha Tomushev <misha@fabric7.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIOC: New Network Device Driver
Message-ID: <20060910222109.GA22386@electric-eye.fr.zoreil.com>
References: <000501c6d85c$08a352f0$8301a8c0@calvados> <200609102339.25621.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609102339.25621.arnd@arndb.de>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> :
[...]
> A few comments on coding style:

Add:
- use netdev_priv()
- use DMA_{32/64}_BIT_MASK in place of private #define
- turn some define into enum ?

-- 
Ueimor
