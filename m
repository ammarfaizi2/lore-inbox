Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130359AbRBFUjn>; Tue, 6 Feb 2001 15:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130358AbRBFUjd>; Tue, 6 Feb 2001 15:39:33 -0500
Received: from m252-mp1-cvx1a.col.ntl.com ([213.104.68.252]:38660 "EHLO
	[213.104.68.252]") by vger.kernel.org with ESMTP id <S129293AbRBFUjW>;
	Tue, 6 Feb 2001 15:39:22 -0500
To: <rob@sysgo.de>
Cc: "Hacksaw" <hacksaw@hacksaw.org>, "Pavel Machek" <pavel@suse.cz>,
        "Patrizio Bruno" <patrizio@dada.it>, <linux-kernel@vger.kernel.org>
Subject: Re: Disk is cheap?
In-Reply-To: <200102061528.f16FSir15100@habitrail.home.fools-errant.com>
	<01020616352700.04185@rob>
From: "John Fremlin" <chief@bandits.org>
Date: 06 Feb 2001 20:17:48 +0000
In-Reply-To: Robert Kaiser's message of "Tue, 6 Feb 2001 16:30:12 +0100"
Message-ID: <m23ddrd0r7.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Robert Kaiser <rob@sysgo.de> writes:

> On Die, 06 Feb 2001 you wrote:
> > But paring down the startup scripts is a good idea. For something like an embedded 
> > device, you might even want to go with a custom init, 

Plug: How about jinit (my init) ;-)

        http://www.penguinpowered.com/~vii/programs/linux/jinit
        http://john.snoop.dk/programs/linux/jinit

Boot script time with the supplied example scripts is 12-13 seconds to
login prompt under 2.4 on my old K6-2. Jinit has integrated service
stop/start functionality. Also on the page are links to other source
available inits.

[...]

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
