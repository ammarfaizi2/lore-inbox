Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRCSUuo>; Mon, 19 Mar 2001 15:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRCSUuf>; Mon, 19 Mar 2001 15:50:35 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:42478
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131590AbRCSUuY>; Mon, 19 Mar 2001 15:50:24 -0500
Date: Mon, 19 Mar 2001 13:46:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "J. Michael Kolbe" <wicked@convergence.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: sysrq.txt
Message-ID: <20010319134653.C22291@opus.bloom.county>
In-Reply-To: <20010316161919.A30690@midget.convergence.de> <20010318233955.D13058@bug.ucw.cz> <20010319091559.A22291@opus.bloom.county> <20010319203659.A17888@dontpanic.int.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010319203659.A17888@dontpanic.int.convergence.de>; from wicked@convergence.de on Mon, Mar 19, 2001 at 08:37:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2001 at 08:37:00PM +0100, J. Michael Kolbe wrote:
> On Mon, Mar 19, 2001 at 09:15:59AM -0700, Tom Rini wrote:
> > Speaking of reversed, there's a slightly "nicer" one in 2.2.18+:
> > On PowerPC - You press 'ALT-Print Screen-<command key>'.
> > 
> > (And yes, all the apple keyboards I've seen w/ F13 have Print Screen
> > right below it).  Tho I'm also rather sure this didn't get into
> > Linus' tree until after the 2.3 split..
> > 
> Well, my Apple Keyboard doesn't. It's F13. And it doesn't work with 'ALT'.
> I suppose that's why it didn't get into the mainstream tree.

But anyways.  My objects were it's not just "macs".  And not all keyboards
have "F13" written on them as well as Print Screen.  Which is why I think
what 2.2 has is what 2.4 should have.  Or if yours doesn't say Print Screen:

On PowerPC - You press 'ALT-Print Screen (or F13)-<command key>

As to weather or not it's the key which says "ALT" on it or not, it is the
key which provides the ALT keycode in linux.  Or it very well should be, for
consistencys sake.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
