Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRCSQTj>; Mon, 19 Mar 2001 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131499AbRCSQT3>; Mon, 19 Mar 2001 11:19:29 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:39150
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131497AbRCSQTZ>; Mon, 19 Mar 2001 11:19:25 -0500
Date: Mon, 19 Mar 2001 09:15:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: "J. Michael Kolbe" <wicked@convergence.de>, linux-kernel@vger.kernel.org
Subject: Re: sysrq.txt
Message-ID: <20010319091559.A22291@opus.bloom.county>
In-Reply-To: <20010316161919.A30690@midget.convergence.de> <20010318233955.D13058@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010318233955.D13058@bug.ucw.cz>; from pavel@suse.cz on Sun, Mar 18, 2001 at 11:39:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2001 at 11:39:55PM +0100, Pavel Machek wrote:
> Hi!
> 
> > I've found that the Sysrq Keys on Apple Computers
> > are 'Keypad+-F13-<command key>', maybe it would
> > be a good idea to include that in Documentation/sysrq.txt.
> > 
> > The Patch:
> 
> This patch is reversed, but otherwise looks okay. Generate
> non-reversed one and mail it to linus, possibly saying I agree.

Speaking of reversed, there's a slightly "nicer" one in 2.2.18+:
On PowerPC - You press 'ALT-Print Screen-<command key>'.

(And yes, all the apple keyboards I've seen w/ F13 have Print Screen
right below it).  Tho I'm also rather sure this didn't get into
Linus' tree until after the 2.3 split..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
