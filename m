Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSKNOwy>; Thu, 14 Nov 2002 09:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSKNOwy>; Thu, 14 Nov 2002 09:52:54 -0500
Received: from posti3.jyu.fi ([130.234.5.32]:56212 "EHLO posti3.jyu.fi")
	by vger.kernel.org with ESMTP id <S264901AbSKNOwx>;
	Thu, 14 Nov 2002 09:52:53 -0500
Date: Thu, 14 Nov 2002 16:59:46 +0200 (EET)
From: Jani Averbach <jaa@cc.jyu.fi>
To: <linux-kernel@vger.kernel.org>
Subject: Re: How do I re-activate IDE controller (secondary channel) after
 boot?
In-Reply-To: <Pine.LNX.4.33.0211140949090.1092-100000@router.windsormachine.com>
Message-ID: <Pine.GSO.4.33.0211141655040.19612-100000@tukki.cc.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Mike Dresser wrote:

> Don't disable the ide channel, set the hard drive type to none in the
> bios, instead of auto.

It was set to none. I emphazise that bios will halt if drive is connected
in 80G mode, regardless of bios setting (Disabling ide-2 will help,
however).

I have found 3 different way to boot machine with this hd so far:
1) jumpper drive to 32G mode
2) disable ide-2 channel
3) don't connect disk's cables at all. =)


BR, Jani

--
Jani Averbach

