Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTAYTpZ>; Sat, 25 Jan 2003 14:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTAYTpZ>; Sat, 25 Jan 2003 14:45:25 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:7633 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261868AbTAYTpY>;
	Sat, 25 Jan 2003 14:45:24 -0500
Date: Sat, 25 Jan 2003 20:54:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, John Bradford <john@grabjohn.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Corrected] Set2 scancodes for Japanese keyboard
Message-ID: <20030125205432.A17993@ucw.cz>
References: <20030125183001.F16711@ucw.cz> <200301251737.h0PHbcZY001157@darkstar.example.net> <20030125184046.A16824@ucw.cz> <20030125194804.GB2495@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030125194804.GB2495@win.tue.nl>; from aebr@win.tue.nl on Sat, Jan 25, 2003 at 08:48:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 08:48:04PM +0100, Andries Brouwer wrote:

> > I'm sorry to tell you after you wrote it all down, but these are set1
> > scancodes you see.
> 
> What about "translated set2" ?

Correct.

> So far I have not yet seen cases where the translation was nonstandard.
> That is, for all keyboards I have looked at or received reports on
> the table given in
> 	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-4.html#kscancodes
> described the conversion from set2 to set1.
> 
> So, given the translated set2 codes, also the original set2 codes are
> known with high probability. (The translation is almost 1-1.)

Correct. Given set of not translated set2 codes, the translated set2
codes are created much easier, hence the not translated set2 codes offer
better value.

And, translated set3 just plain doesn't make sense.

-- 
Vojtech Pavlik
SuSE Labs
