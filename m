Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWCDQ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWCDQ4a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWCDQ43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:56:29 -0500
Received: from stinky.trash.net ([213.144.137.162]:29641 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932188AbWCDQ43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:56:29 -0500
Message-ID: <4409C6BA.60803@trash.net>
Date: Sat, 04 Mar 2006 17:56:26 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] let NET_CLS_ACT no longer depend on EXPERIMENTAL
References: <20060304160755.GB9295@stusta.de>
In-Reply-To: <20060304160755.GB9295@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This option should IMHO no longer depend on EXPERIMENTAL.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 12 Feb 2006

Yesterday I managed to crash my machine playing around with tc actions
within minutes. I haven't looked into it yet, but it seems it still
needs more testing.
