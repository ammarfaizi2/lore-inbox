Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276907AbRJKUsO>; Thu, 11 Oct 2001 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276912AbRJKUsE>; Thu, 11 Oct 2001 16:48:04 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:45362 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S276911AbRJKUru>;
	Thu, 11 Oct 2001 16:47:50 -0400
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Module read a file?
From: Mark Atwood <mra@pobox.com>
Date: 11 Oct 2001 13:48:18 -0700
In-Reply-To: Dan Hollis's message of "Thu, 11 Oct 2001 13:16:51 -0700 (PDT)"
Message-ID: <m38zehucml.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm modifying a PCMCIA driver module so that it can load new firmware
into the card when it's inserted.

Rather than including the firmware inside the module's binary, I would
much rather be able to read it out of the filesystem.

Are their any good examples of kernel code or kernel modules reading a
file out of the filesystem that I could copy or at least look to for
inspiration?

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
