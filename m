Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVAOHY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVAOHY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 02:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVAOHY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 02:24:28 -0500
Received: from mx.freeshell.org ([192.94.73.21]:56518 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S262234AbVAOHYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:24:05 -0500
Date: Sat, 15 Jan 2005 07:23:38 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501122242.51686.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501150720190.11993@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <200501110239.33260.dtor_core@ameritech.net> <Pine.NEB.4.61.0501130315500.11711@sdf.lonestar.org>
 <200501122242.51686.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having disabled ALL mouse functionality (including 'mousedev'), I 
compiled 2.6.9-rc2-bk2.  On bootup, keyboard input worked great.
So many it's a conflict with the mouse driver then.
BTW, I haven an MSI NEO K8T FIS2R motherboard with an athlon64/3200+,
for what it's worth.
I will follow up with logs shortly.


Roey


On Wed, 12 Jan 2005, Dmitry Torokhov wrote:

[snip]
> And what if you do not compile PS/2 mouse support in? Is keyboard still
> dead?
>
[snip]
