Return-Path: <linux-kernel-owner+w=401wt.eu-S1161229AbXAHLRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbXAHLRY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161230AbXAHLRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:17:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:62504 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161229AbXAHLRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:17:23 -0500
Mime-Version: 1.0
Message-Id: <a06230924c1c7d795429a@[192.168.2.101]>
In-Reply-To: <45A2356B.5050208@gmx.net>
References: <45A22D69.3010905@gmx.net>
 <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com>
 <45A2356B.5050208@gmx.net>
Date: Mon, 8 Jan 2007 12:17:20 +0100
To: Dirk <d_i_r_k_@gmx.net>, Trent Waddington <trent.waddington@gmail.com>
From: Jay Vaughan <jv@access-music.de>
Subject: Re: Gaming Interface
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:5cf4d1416b705699c92259bb5d2086df
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:13 +0100 8/1/07, Dirk wrote:
>Trent Waddington wrote:
>  > Call me crazy, but game manufacturers want directx right?  You aint
>  > running that in the kernel.
>They want something like DirectX that changes it's API less frequent
>than DirectX and that compiles as a module because you don't want to run
>it in the kernel.
>

Whats wrong with just using SDL/OpenGL?  Thousands of games are made 
with SDL/OpenGL, and there are realms of Linux usage where this works 
just fine, especially for games (GP2X, etc).  In case you didn't 
notice, plenty of pro Game Developers use SDL/OpenGL just fine for 
their needs, and get the job done without grumbling and groaning 
about needing to have their hands held through the process.

I fail to see the reason this requirement has to be a 'kernel' 
interface, other than pure sheer laziness and inability to grok on 
the part of the so-called professional Game Developers.  Gaming is 
only *one* kind of application for the Linux kernel - shall we burden 
the kernel with everything everyone wants just because people fail to 
understand the proper way to assemble a Linux-based kit for their 
specific application needs?  (Hint: work with the distro builders.)

Just my .2c, but anyone suggesting that API's be crowbar'ed into the 
kernel "just to make it easier to get what you want from a single 
source" is probably not as familiar with the underlying technology, 
nor the reasons for its structured organization, as they ought to be 
before making such suggestions ..

-- 

;

Jay Vaughan

