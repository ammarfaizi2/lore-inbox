Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268014AbTAIWQU>; Thu, 9 Jan 2003 17:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268044AbTAIWQU>; Thu, 9 Jan 2003 17:16:20 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:37039 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S268014AbTAIWQT>;
	Thu, 9 Jan 2003 17:16:19 -0500
Date: Thu, 9 Jan 2003 23:24:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: MB without keyboard controller / USB-only keyboard ?
Message-ID: <20030109232459.A24656@ucw.cz>
References: <20030109114247.211f7072.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030109114247.211f7072.skraw@ithnet.com>; from skraw@ithnet.com on Thu, Jan 09, 2003 at 11:42:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 11:42:47AM +0100, Stephan von Krawczynski wrote:
> Hello all,
> 
> how do I work with a mb that contains no keyboard controller, but has only USB
> for keyboard and mouse?
> While booting the kernel I get:
> 
> pc_keyb: controller jammed (0xFF)
> 
> (a lot of these :-)
> 
> and afterwards I cannot use the USB keyboard.
> Everything works with a mb that contains a keyboard-controller, but where I use a
> USB keyboard.

Get 2.5. ;) It should work without a kbd controller ... you can even
disable it in the kernel config ...

-- 
Vojtech Pavlik
SuSE Labs
