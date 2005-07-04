Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVGDGop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVGDGop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVGDGop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:44:45 -0400
Received: from node-40240a4a.sjc.onnet.us.uu.net ([64.36.10.74]:17412 "EHLO
	sphinx.zankel.net") by vger.kernel.org with ESMTP id S261522AbVGDGnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 02:43:37 -0400
Message-ID: <42C8DC70.4090602@zankel.net>
Date: Sun, 03 Jul 2005 23:51:28 -0700
From: Christian Zankel <chris@zankel.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050210)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: czankel@tensilica.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: arch xtensa does not compile
References: <42BD6557.9070102@ppp0.net> <42BD8622.8060506@zankel.net> <42C80B34.80007@ppp0.net>
In-Reply-To: <42C80B34.80007@ppp0.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:

> Current git tip (2.6.12-rc1-git5) still does not compile for me:
> I guess I'm using the wrong binutils version (2.15.94.0.2.2). Which is the
> recommended gcc/binutils pair which is supposed to compile the kernel?

Unfortunately, I don't think the correct configuration is currently 
checked into the binutils/gcc tree. I'll talk to Bob (he is the 
maintainer for binutils+gcc for Xtensa) when I have a chance (Monday is 
  Independence Day). It compiles fine with a local copy of binutils+gcc 
with the correct configuration.

BTW, I really like your website. Are you planing to release the script 
files?

Thanks,
~Chris




