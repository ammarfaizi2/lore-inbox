Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSHaH4w>; Sat, 31 Aug 2002 03:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSHaH4w>; Sat, 31 Aug 2002 03:56:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28686 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S316446AbSHaH4w>;
	Sat, 31 Aug 2002 03:56:52 -0400
Date: Sat, 31 Aug 2002 10:01:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Christopher Keller <cnkeller@interclypse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18: APM & ASUS A7M266-D
Message-ID: <20020831080110.GA27308@alpha.home.local>
References: <1030744641.2588.64.camel@c_keller.beamreachnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030744641.2588.64.camel@c_keller.beamreachnetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 02:57:15PM -0700, Christopher Keller wrote:
> 
> The result, as far as I can tell, is that the machine doesn't power off
> when executing a shutdown/init 0. It simply displays the "Power Down"
> message and sits there. 
> 
> Booting with the "apm=power-off" flag doesn't seem to have any effect. 

upgrade your kernel to latest 2.4.20-pre or latest -ac. I had same and other
problems with APM on the same board, and they are now fixed.

Willy
