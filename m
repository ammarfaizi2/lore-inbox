Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288973AbSA3IMf>; Wed, 30 Jan 2002 03:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSA3IKw>; Wed, 30 Jan 2002 03:10:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24014 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S288971AbSA3IJx>;
	Wed, 30 Jan 2002 03:09:53 -0500
Date: Wed, 30 Jan 2002 03:09:50 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: bug tracking (was Re: A modest proposal -- We need a patch penguin)
Message-ID: <20020130030950.E32317@havoc.gtf.org>
In-Reply-To: <E16VgQ0-0000AS-00@starship.berlin> <Pine.LNX.4.44.0201300136430.25123-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0201300136430.25123-100000@waste.org>; from oxymoron@waste.org on Wed, Jan 30, 2002 at 01:41:22AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:41:22AM -0600, Oliver Xymoron wrote:
> The gross fixes tend to get dropped because if they're in, the proper fix
> loses priority. FIXMEs can take many years to fix. The problem seems not
> to be the dropping of the patch so much as the dropping of the bug report
> and bug tracking is an altogether different problem.

Indeed.  The issue of kernel bug tracking gets pondered and discussed
every few months it seems (not without need, mind you).

To tie this back into the original whine from RobL, what we do NOT need
is a patch secretary.  What we do need, desperately, is
(a) a bug-tracking system, and
(b) at least one sharp person, with bunches of help from kernel
developers and users alike, to close fixed bugs, ping users, clear out
garbage so that the bug database has a very high signal-to-noise ratio.

Good kernel bug tracking can be done, but it requires human maintenance,
by someone or someones with a brain.  It cannot be done without plenty
of automation, though, as tytso (god bless him for trying!) showed...

Such would be a significant boon to -all- Linux users.

	Jeff


