Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWGJEVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWGJEVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 00:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWGJEVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 00:21:23 -0400
Received: from stinky.trash.net ([213.144.137.162]:62088 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1161334AbWGJEVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 00:21:23 -0400
Message-ID: <44B1D56C.20903@trash.net>
Date: Mon, 10 Jul 2006 06:19:56 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: coreteam@netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] netfilter: fix SYSCTL=n compile
References: <20060708202023.GE5020@stusta.de> <44B079FF.8060909@trash.net> <20060709233304.GX13938@stusta.de>
In-Reply-To: <20060709233304.GX13938@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch fixes the following compile errors with CONFIG_SYSCTL=n 
> introduced by commit 39a27a35c5c1b5be499a0576a35c45a011788bf8:

Thanks, applied.

