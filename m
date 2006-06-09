Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbWFINQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbWFINQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbWFINQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:16:51 -0400
Received: from secure.htb.at ([195.69.104.11]:29962 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S965254AbWFINQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:16:50 -0400
Date: Fri, 9 Jun 2006 15:16:40 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Caching kernel messages at boot
Message-Id: <20060609151640.baf93426.delist@gmx.net>
In-Reply-To: <448991CD.9070404@free.fr>
References: <448991CD.9070404@free.fr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\
 t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>
 ~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']k
 JW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1Fogqt-00040B-00*1YTX.5Df6Rw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach "s.a." <sancelot@free.fr> (Fri, 09 Jun 2006 15:20:45 +0000):
> Hi,
> Is there a way to hide the kernel messages from the screen at boot ?

Use the bootparameter "quiet" e.g. <vmlinuz-image> root=/dev/sda3 quiet
or one of those framebuffer splash screens.

> Best Regards
> Steph

sl ritch
