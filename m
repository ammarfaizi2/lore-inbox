Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTAYRU4>; Sat, 25 Jan 2003 12:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTAYRU4>; Sat, 25 Jan 2003 12:20:56 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:43466 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261530AbTAYRUv>;
	Sat, 25 Jan 2003 12:20:51 -0500
Date: Sat, 25 Jan 2003 18:30:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Corrected] Set2 scancodes for Japanese keyboard
Message-ID: <20030125183001.F16711@ucw.cz>
References: <20030125120113.B28830@ucw.cz> <200301251728.h0PHSPZX001013@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200301251728.h0PHSPZX001013@darkstar.example.net>; from john@grabjohn.com on Sat, Jan 25, 2003 at 05:28:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 05:28:25PM +0000, John Bradford wrote:

> Some got missed off the first time:

What kernel this is tested with? What method used? These don't look like
Set2 codes AT ALL.

> 
> Key
> Keycode
> Make scancode
> Break scancode
> 
> Escape
> 1
> 0x01
> 0x81
> 
> F1
> 59
> 0x3b
> 0xbb
> 
> F10
> 68
> 0x44
> 0xc4
> 
> F11
> 87
> 0x57
> 0xd7
> 
> F12
> 88
> 0x58
> 0xd8
> 
> Printscreen?, (marked 'page', and something I can't read).
> 99
> 0xe0 0x2a 0xe0 0x37
> 0xe0 0xb7 0xe0 0xaa
> 
> Sys Rq, (alt and key above)
> 84
> 0x54
> 0xd4
> 
> Scroll lock
> 70
> 0x46
> 0xc6
> 
> Numlock, (shift scroll lock)
> 69
> 0x45
> 0xc5
> 
> Pause
> 119
> 0xe1 0x1d 0x45
> 0xe1 0x9d 0xc5
> 
> Break
> 101
> 0xe0 0x46
> 0xe0 0xc6
> 
> Hankaku/Zenkaku
> None
> 0xff
> none
> 
> 1
> 2
> 0x02
> 0x83
> 
> 0
> 11
> 0x0b
> 0x8b
> 
> -
> 12
> 0x0c
> 0x8c
> 
> shift -
> 13
> 0xb6 0x0d
> 0x8d 0x36
> 
> ^
> 42,7
> 0x2a 0x07
> 0x8  0xaa
> 
> shift ^
> none
> 0xff
> none
> 
> yen
> none
> 0xff
> none
> 
> shift yen ( | )
> 43
> 0x2b
> 0xab
> 
> backspace
> 14
> 0x0e
> 0x8e
> 
> tab
> 15
> 0x0f
> 0x8f
> 
> q
> 16
> 0x10
> 0x90
> 
> p
> 25
> 0x19
> 0x99
> 
> @
> 42,3
> 0x2a 0x03
> 0x83 0xaa
> 
> shift @
> release 54, 41, release 41, 54
> 0xb6 0x29
> 0xa9 0x36
> 
> [
> 26
> 0x1a
> 0x9a
> 
> enter
> 28
> 0x1c
> 0x9c
> 
> caps lock
> 58
> 0x3a
> 0xba
> 
> a
> 30
> 0x1e
> 0xae
> 
> l
> 38
> 0x26
> 0xa6
> 
> ;
> 39
> 0x27
> 0xa7
> 
> shift ; ( + )
> 13
> 0x0d
> 0x8d
> 
> :
> 42 39
> 0x2a 0x27
> 0xa7 0xaa
> 
> shift : ( * )
> 9
> 0x09
> 0x89
> 
> ]
> 27
> 0x1b
> 0x9b
> 
> left shift 42
> 0x2a
> 0xaa
> 
> z
> 44
> 0x2c
> 0xad
> 
> m
> 50
> 0x32
> 0xb2
> 
> ,
> 51
> 0x33
> 0xb3

-- 
Vojtech Pavlik
SuSE Labs
