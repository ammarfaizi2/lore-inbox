Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262572AbSJGRNj>; Mon, 7 Oct 2002 13:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbSJGRNj>; Mon, 7 Oct 2002 13:13:39 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:10120 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262572AbSJGRNS>;
	Mon, 7 Oct 2002 13:13:18 -0400
Date: Mon, 7 Oct 2002 19:18:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: crozierm@consumption.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard/mouse "freeze" with uhci error in logs
Message-ID: <20021007191846.B1978@ucw.cz>
References: <Pine.LNX.4.21.0210060052510.31233-100000@consumption.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0210060052510.31233-100000@consumption.net>; from crozierm@consumption.net on Sun, Oct 06, 2002 at 12:58:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 12:58:59AM -0700, crozierm@consumption.net wrote:
> 
> Hello,
> 
> I'm trying 2.5.40 and frequently my keyboard and mouse are "freezing",
> usually accompanying a change in the console (exiting xfree86 or
> switching virtual consoles).  Otherwise everything is fine, I can telnet
> in and reboot.
> 
> This is the message that I found in the logs:
> 
> kernel: uhci-hcd.c: ef80: host controller process error. something bad
> happened
> 
> kernel: uhci-hcd.c: ef80: host controller halted. very bad
> 
> 
> If I can provide more information, please email me directly as I'm not on 
> the list.

Do you have  USB or PS/2  keyboard and mouse?

-- 
Vojtech Pavlik
SuSE Labs
