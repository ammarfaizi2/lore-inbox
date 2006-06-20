Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWFTVtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWFTVtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWFTVtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:49:20 -0400
Received: from secure.htb.at ([195.69.104.11]:38930 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1750736AbWFTVtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:49:19 -0400
Date: Tue, 20 Jun 2006 23:49:12 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bootmsg: unable to open rtc device (rtc0)
Message-Id: <20060620234912.73f2b4dd.delist@gmx.net>
In-Reply-To: <20060620231408.c8c8120b.delist@gmx.net>
References: <20060620231408.c8c8120b.delist@gmx.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\
 t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>
 ~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']k
 JW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1Fso5v-0007qj-00*mNOIxD76DZk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Richard Mittendorfer <delist@gmx.net> (Tue, 20 Jun 2006 23:14:08 +0200):
> I get this dmesg-message on all my lately build kernels:
> 
> ...
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> ...

http://lkml.org/lkml/2005/12/20/220

Doesn't look like I'll really need it on these boxes.

I think the naming is somewhat confusing as it doesn't seem to include
the standard RTC build right onto the motherboards? Or is it a new
implementation which does/will handle these too? 

sorry for the noise,
sl ritch
