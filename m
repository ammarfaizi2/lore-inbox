Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265828AbTAOH7G>; Wed, 15 Jan 2003 02:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbTAOH7G>; Wed, 15 Jan 2003 02:59:06 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:62871 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265828AbTAOH7F>;
	Wed, 15 Jan 2003 02:59:05 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15909.5853.816432.60649@harpo.it.uu.se>
Date: Wed, 15 Jan 2003 09:07:57 +0100
To: Rui Sousa <rui.sousa@laposte.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] emu10k1 forward port (2.4.20 to 2.5.56)
In-Reply-To: <Pine.LNX.4.44.0301111330440.4899-101000@localhost.localdomain>
References: <Pine.LNX.4.44.0301111330440.4899-101000@localhost.localdomain>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Sousa writes:
 > Since the driver is still in the tree and several people already asked for
 > it, here is an update to the OSS emu10k1 driver in 2.5.56. This is the 
 > exactly same driver as in 2.4.20, it fixes a compile warning and a number 
 > of bugs:

Tested in kernel 2.5.58 with an SB Live 5.1. Works great with Quake :-)
And it killed those bitops compile warnings, so I'm happy with it.

/Mikael
