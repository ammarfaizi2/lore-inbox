Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTHOUs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270865AbTHOUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:48:26 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:50652
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S270859AbTHOUsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:48:18 -0400
Date: Fri, 15 Aug 2003 22:50:55 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O16int for interactivity
Message-Id: <20030815225055.65c74573.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-08-15 19:00:00 Felipe Alfaro Solana wrote:

[...]
> Is anyone experiencing those extreme delays? Is this a new kind of
> starvation? Cause using exactly the same machine, Linux distribution,
> disk partition, etc... but simply by changing kernels, almost
> everything on boot takes twice the time to be done.

Ditto, with handcrafted simple scripts in my rc.d. About twice as long.
But that's not all... Game-test can't be run. I waited 4 minutes for it
to start the intro sequences (normally 10 seconds), clicked to load a
saved game, got neverending "sound repeats". Patiently logged in on a
text console and patiently killed the rouge processes. Took about five
minutes of starvation to squeeze in keystrokes with the few seconds of
interactivety now and then.

Rotating the world in Blender quickly "jerks", but now the pauses are
extended to more than 10 seconds (previously 1/2 to 2)

Ringing the bell and shouting "Unclean, unclean!"
Mats Johannesson
