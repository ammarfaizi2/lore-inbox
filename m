Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSJCRiO>; Thu, 3 Oct 2002 13:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261669AbSJCRiO>; Thu, 3 Oct 2002 13:38:14 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:48256 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261642AbSJCRiM>;
	Thu, 3 Oct 2002 13:38:12 -0400
Date: Thu, 3 Oct 2002 19:43:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: jbradford@dial.pipex.com
Cc: vojtech@suse.cz (Vojtech Pavlik), tori@ringstrom.mine.nu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003174342.GA19783@win.tue.nl>
References: <20021003144319.A38785@ucw.cz> <200210031320.g93DKnqx000460@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210031320.g93DKnqx000460@darkstar.example.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:20:48PM +0100, jbradford@dial.pipex.com wrote:

> > Do you by any chance know the names of the unknown keys so that I could
> > add them to the Set 3 default scancode map?
> 
> All I can tell you is a translation of what is written on the scancode 0x87 key
> on this particular keyboard:
> 
> 'Hiragana/Roma_characters'
> 
> I can't translate the characters on the other keys.
> 
> However, somebody else might be able to - I found this diagram of the keyboard:
> 
> http://www.pfu.co.jp/hhkeyboard/kb_collection/ibm5576-002.gif
> 
> The legends on the bottom row of keys are exactly the same as on my keyboard,
> and from left to right, they have the following functions:
> 
> Control
> ALT, (it says, 'Kanji/Katakana/Kanji???', but works as ALT)
> Scancode 0x85
> Space bar
> Scancode 0x86
> Scancode 0x87, (it says, 'Hiragana/Roma characters')
> ALT GR
> Control

For an explanation of the other keys, see

http://www.win.tue.nl/~aeb/linux/kbd/scancodes-3.html

(muhenkan / henkan).

Andries

