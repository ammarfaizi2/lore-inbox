Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTIZNle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 09:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTIZNle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 09:41:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:27543 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262193AbTIZNlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 09:41:32 -0400
Date: Fri, 26 Sep 2003 15:41:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030926134116.GA9721@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t> <20030926102403.GA8864@ucw.cz> <1064572898.21735.17.camel@ulysse.olympe.o2t> <1064581715.23200.9.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064581715.23200.9.camel@ulysse.olympe.o2t>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 03:08:36PM +0200, Nicolas Mailhot wrote:

> | > > > Couldn't it at least detect there's a problem ? Most people I know do not press a key
> | > > > 2000+ times in a row during normal activity.
> | > > 
> | > > You do. Scrolling up/down in a document is one example. And there is no
> | > > point to limit the repeat to say 80 or 200 characters. You would still
> | > > hate having 80 repeated characters and then it stopping.
> | > 
> | > Well then only allow monster autorepeats for arrows then.
> | > (they are never stuck in my board anyway;)
> 
> | And j, k, w, b, ., all function keys, <bs>, <del>, <cr>,
> | <sp>, <tab> and any other key used by any editor or game for
> | navigation, level control or other function where the same
> | key would be used scores of times in in rapid sequence.
> 
> score << 2k+
> 
> I wrote about monster autorepeats not every single duplicated keypress.
> I fully agree it's stupid to expect detecting every single bogus repeat.
> 
> However saying the system has no way to guess monster
> autorepeats=problem is just plain wrong. There *are* thresholds after
> which one can be 99% sure there is a problem (autorepeat gone mad or cat
> sitting on the keyboard). No one is going to complain he has to release
> a key every hundred or so repeats to confirm there's a human on the
> other side of the keyboard.

But what use would be this? You'd still get a screenful of 'j's for
example, maybe only 200 instead of 2000, but where is the difference?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
