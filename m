Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWBBPvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWBBPvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWBBPvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:51:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37782 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbWBBPvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:51:23 -0500
Date: Thu, 2 Feb 2006 07:51:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git pull] drm patches for 2.6.16
In-Reply-To: <Pine.LNX.4.58.0602020913460.19173@skynet>
Message-ID: <Pine.LNX.4.64.0602020749510.21884@g5.osdl.org>
References: <Pine.LNX.4.58.0602020913460.19173@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Feb 2006, Dave Airlie wrote:
> 
> commit 30e2fb188194908e48d3f27a53ccea6740eb1e98
> Author: Dave Airlie <airlied@starflyer.(none)>
> Date:   Thu Feb 2 19:37:46 2006 +1100
> 
>     sem2mutex: drivers/char/drm/
> 
>     From: Arjan van de Ven <arjan@infradead.org>

A lot of your commits have this structure.

What do you use to apply these emails? It _looks_ like the emails are 
well-behaved ("From:" at the top), yet your Author: information is wrong 
and whatever script you used to do it missed it.

		Linus
