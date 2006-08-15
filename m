Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWHOVI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWHOVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWHOVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:08:56 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:10970 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750711AbWHOVIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:08:55 -0400
Date: Tue, 15 Aug 2006 23:04:56 +0200
From: Martin Samuelsson <sam@home.se>
To: Adrian Bunk <bunk@stusta.de>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: drivers/media/video/bt866.c: array overflows
Message-Id: <20060815230456.ed280109.sam@home.se>
In-Reply-To: <20060815181320.GB7813@stusta.de>
References: <20060814232337.GZ3543@stusta.de>
	<20060815080618.50200f6b.sam@home.se>
	<20060815181320.GB7813@stusta.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 20:13:20 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Tue, Aug 15, 2006 at 08:06:18AM +0200, Martin Samuelsson wrote:
> > Obviously, as you've found bugs in it, I didn't look in the right places. Where, pray tell, did the little critter go?
> >...
> 
> It's in 2.6.18-rc4.

Nice, it hid in Linus' tree for a while, then. Compiling it now.

Thanks!

/Sam
