Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbTBGLEB>; Fri, 7 Feb 2003 06:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267789AbTBGLEB>; Fri, 7 Feb 2003 06:04:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267726AbTBGLEA>;
	Fri, 7 Feb 2003 06:04:00 -0500
Date: Fri, 7 Feb 2003 18:03:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][5/6] CPU Hotplug i386
Message-ID: <20030207170030.GA2054@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0302030550480.9361-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302030550480.9361-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +#ifdef CONFIG_HOTPLUG
> +static inline void maybe_play_dead(void)

Maybe config_CPU_hotplug would be a better
name?
				Pavel

