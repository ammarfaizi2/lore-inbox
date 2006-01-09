Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWAIRty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWAIRty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWAIRty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:49:54 -0500
Received: from ezoffice.mandriva.com ([84.14.106.134]:24584 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1030213AbWAIRtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:49:53 -0500
From: Thierry Vignaud <tvignaud@mandriva.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Martin Drab <drab@kepler.fjfi.cvut.cz>, Takashi Iwai <tiwai@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
Organization: Mandrakesoft
References: <20060104030034.6b780485.zaitcev@redhat.com>
	<Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
	<Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
	<Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
	<Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
	<s5hmziaird8.wl%tiwai@suse.de>
	<Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl>
	<s5h8xtshzwk.wl%tiwai@suse.de> <20060108020335.GA26114@dspnet.fr.eu.org>
	<Pine.LNX.4.60.0601080317040.22583@kepler.fjfi.cvut.cz>
	<20060108132122.GB96834@dspnet.fr.eu.org>
X-URL: <http://www.linux-mandrake.com/
Date: Mon, 09 Jan 2006 18:49:49 +0100
In-Reply-To: <20060108132122.GB96834@dspnet.fr.eu.org> (Olivier Galibert's
	message of "Sun, 8 Jan 2006 14:21:22 +0100")
Message-ID: <m2ace5jnpe.fsf@vador.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert <galibert@pobox.com> writes:

> - stop making a fundamentally unsecure shared library mandatory

do you speak about known vulnerabilities in ALSA lib or are you
trolling^h^h^h^h^h^h^h assuming that kernel code is safer than
userspace one?

afaic I don't assume this.
I'd prefer see bad code make one app crashing than oopsing the whole
machine.

