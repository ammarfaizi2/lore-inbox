Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130823AbRBLKVV>; Mon, 12 Feb 2001 05:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130704AbRBLKVL>; Mon, 12 Feb 2001 05:21:11 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130823AbRBLKUy>;
	Mon, 12 Feb 2001 05:20:54 -0500
Message-ID: <20010211230113.I3748@bug.ucw.cz>
Date: Sun, 11 Feb 2001 23:01:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: making forward at vger.rutgers.org? [was Re: maestro3 patch, resent]
In-Reply-To: <20010207100619.A8529@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010207100619.A8529@tetsuo.zabbo.net>; from Zach Brown on Wed, Feb 07, 2001 at 10:06:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> duh.  I sent this to rutgers originally..

I'm doing same mistake over and over.

Perhaps creating forward at vger.rutgers.edu would be good thing (tm)?

								Pavel

> --- 
> 
> Date: Mon, 5 Feb 2001 07:42:25 -0500
> From: Zach Brown <zab@zabbo.net>
> To: linux-kernel@vger.rutgers.edu
> Subject: [PATCH] maestro3 2.4.1-ac2 shutdown fix
> 
> Its a wonder that anyone lets me write code.
> 
> The following fixes a goofy shutdown problem with the 2.4 maestro3 driver
> as it appears in Alan's 2.4.1-ac2 patch.   If power management was
> disabled the maestro3 driver would oops trying to save the dsp state as
> the machine shut down.  
> 
> The full source for the up to date 2.4 driver can be found at:
> 
> 	http://www.zabbo.net/maestro3/maestro3-2.4-20010204.tar.gz
> 
> thanks again to Andres Salomon for continuing to report my dumb bugs.
> Hopefully this will be the last of the trivial bugs, this driver needs
> some real meaningful cleaning up..
> 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
