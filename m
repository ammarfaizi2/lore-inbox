Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVAGEHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVAGEHD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 23:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVAGEHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 23:07:03 -0500
Received: from mx.freeshell.org ([192.94.73.21]:8907 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261209AbVAGEGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 23:06:53 -0500
Date: Fri, 7 Jan 2005 04:06:47 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501052316.48443.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501070405170.2840@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <Pine.NEB.4.61.0501040543490.25801@sdf.lonestar.org>
 <200501040117.28803.dtor_core@ameritech.net> <200501052316.48443.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

Bingo!
2.6.9-rc2-bk2 worked (where bk3 hadn't before).
The system responded to keyboard input.
What's the next step?


Roey


On Wed, 5 Jan 2005, Dmitry Torokhov wrote:

> Roey,
>
> I just realized that -bk3 also had input changes. Could you try booting -bk2?
>
> -- 
> Dmitry
>
