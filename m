Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVAZAza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVAZAza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVAZAyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:54:44 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:21190 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262098AbVAZAwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:52:46 -0500
Date: Tue, 25 Jan 2005 16:52:15 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, irda-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dag@brattli.net
Subject: Re: [2.6 patch] update Dag Brattli's email address
Message-ID: <20050126005215.GA21409@taniwha.stupidest.org>
References: <20050125144046.GJ30909@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125144046.GJ30909@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:40:46PM +0100, Adrian Bunk wrote:

> This patch updates the email address of Dag Brattli in kernel 2.6 to
> his current address.

>  drivers/net/irda/actisys-sir.c        |    4 ++--
[ ... 
>  CREDITS                               |    6 +-----
>  96 files changed, 233 insertions(+), 237 deletions(-)

This patch is huge.

Do we really need email addresses in all these files?  How about we
remove them and put it in ONE place instead so if it needs to be
updated again we don't need to touch ~96 files?

Surely this makes sense in general too?


