Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUG0Qd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUG0Qd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUG0Qbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:31:36 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:43137 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266477AbUG0QaJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:30:09 -0400
Subject: Re: Problem with snd_atiixp in 2.6.8-rc2 (and a workaround)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <s5hn01l67v6.wl@alsa2.suse.de>
References: <m37jsv3j6a.fsf@telia.com> <m3hdrx6w0p.fsf@telia.com>
	 <1090701125.7455.3.camel@lade.trondhjem.org> <s5hn01l67v6.wl@alsa2.suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1090945801.4711.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 12:30:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 27/07/2004 klokka 06:51, skreiv Takashi Iwai:
> > It still needs to be fixed in the kernel itself. This bug and the fix
> > were both reported during the 2.6.6 cycle: we're now in 2.6.8-rc2...
> > 
> > Why the delay on such a trivial bug?
> 
> It has been already in mm tree for long time...

...and has been available on the ALSA CVS site, yadda, yadda...

That does nothing to change the fact that the *mainline* kernel tree has
been stuck with a trivial but irritating bug.

Trond
