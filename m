Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbTC1DVX>; Thu, 27 Mar 2003 22:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262059AbTC1DVX>; Thu, 27 Mar 2003 22:21:23 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:13823
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261997AbTC1DVW>; Thu, 27 Mar 2003 22:21:22 -0500
Date: Thu, 27 Mar 2003 22:28:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: task_struct slab cache use after free in 2.5.66
In-Reply-To: <Pine.LNX.4.50.0303272211180.2884-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303272226480.2884-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303272211180.2884-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Zwane Mwaikambo wrote:

> I'm having a few stability problems with 2.5.66 under test loads. I 
> can't quite parse the slab debugging stuff. Is this actually useful to 
> anyone?

P5/SMP 192M All the slab debugging nobs on.

-- 
function.linuxpower.ca
