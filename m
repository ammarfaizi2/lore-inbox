Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTAYTi6>; Sat, 25 Jan 2003 14:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbTAYTi6>; Sat, 25 Jan 2003 14:38:58 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:42419 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261874AbTAYTi6>;
	Sat, 25 Jan 2003 14:38:58 -0500
Date: Sat, 25 Jan 2003 20:48:04 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: [Corrected] Set2 scancodes for Japanese keyboard
Message-ID: <20030125194804.GB2495@win.tue.nl>
References: <20030125183001.F16711@ucw.cz> <200301251737.h0PHbcZY001157@darkstar.example.net> <20030125184046.A16824@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030125184046.A16824@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 06:40:46PM +0100, Vojtech Pavlik wrote:

> I'm sorry to tell you after you wrote it all down, but these are set1
> scancodes you see.

What about "translated set2" ?

So far I have not yet seen cases where the translation was nonstandard.
That is, for all keyboards I have looked at or received reports on
the table given in
	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-4.html#kscancodes
described the conversion from set2 to set1.

So, given the translated set2 codes, also the original set2 codes are
known with high probability. (The translation is almost 1-1.)

Andries
