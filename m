Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbTG3KaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270079AbTG3KaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:30:00 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:12769
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S270032AbTG3K37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:29:59 -0400
Date: Wed, 30 Jul 2003 12:31:22 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O11int for interactivity
Message-Id: <20030730123122.3970c7bf.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-07-30 8:41:46 Felipe Alfaro Solana wrote:

> Wops! Wait a minute! O11.1 is great, but I've had a few XMMS skips
> that I didn't have with O10. They're really difficult to reproduce,

Can't reproduce your skips here with my light environment and O11.1 (on
a PII 400, 128 meg mem, no desktop, Enlightenment as wm). Even as I
write this my machine is under the most extreme load that I have -
natural, not artificial:

Playing a directory of mp3s with xmms.

Backing up the system from hda to a partition on hdc (the mp3s are on
that drive but another partition). This involves"rm -rf" of the old
backup, "dd if=/dev/zero of=cleanupfile" as a poor man's wipe, load is
11 there while producing a 15 gig file. "cp -a" all relevant directories
of my system, load is 3 to 7. "cp -a" the backup to a copy on the same
partition. Takes 50 minutes to complete everything.

During this operation I write a "letter" in OpenOffice 1.1rc2 and browse
the net with Opera 6.02. Apart from normal delays while swapped out
things get swapped in (top says 55 megs is swapped), everything is fully
operational. And no music skips ;-)

As to difference between O10 and O11.1 in feel... No comment. I'm too
old to catch such small variations.

Mvh
Mats Johannesson
