Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbSL1U7O>; Sat, 28 Dec 2002 15:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbSL1U7O>; Sat, 28 Dec 2002 15:59:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6152 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S266006AbSL1U7N>;
	Sat, 28 Dec 2002 15:59:13 -0500
Date: Sat, 28 Dec 2002 22:07:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Harald Dunkel <harri@synopsys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vgacon: I like Tux, but ...
Message-ID: <20021228210718.GB596@alpha.home.local>
References: <3E0DFA6A.3020105@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E0DFA6A.3020105@Synopsys.COM>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 08:24:26PM +0100, Harald Dunkel wrote:
> Hi folks,
> 
> I really like to get Tux displayed on the screen at boot time
> (you should see our SMP machines with hyperthreading activated),
> but if I enter single user mode, then the first 5 lines remain
> unusable. I can clear the whole screen, but on scrolling upwards
> the first 5 lines are stuck.

I'm used to clear them with a shift-pgup/shift-pgdn scroll sequence. May be
it's not the best solution, but it has worked for me for years now, so I'm
still using it.

Cheers,
Willy

