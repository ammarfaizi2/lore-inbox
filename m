Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVAGNjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVAGNjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVAGNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:38:07 -0500
Received: from mx.freeshell.org ([192.94.73.21]:32207 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261410AbVAGNhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:37:42 -0500
Date: Fri, 7 Jan 2005 13:37:36 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501070045.24639.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501071336010.23626@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501052316.48443.dtor_core@ameritech.net> <Pine.NEB.4.61.0501070405170.2840@sdf.lonestar.org>
 <200501070045.24639.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Done. (the debug was just that initial #define DEBUG in
drivers/input/serio/i8042.c as you specified)


Roey

On Fri, 7 Jan 2005, Dmitry Torokhov wrote:

> I am not quite sure yet. Could you post the boot log of -bk2 with debug
> enabled on your web site, please?

