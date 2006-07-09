Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWGIAT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWGIAT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWGIAT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:19:28 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:54536 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1161000AbWGIAT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:19:27 -0400
Date: Sun, 9 Jul 2006 02:19:24 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
       Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060709001924.GA71724@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
	Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
	linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
	grundig <grundig@teleline.es>,
	Nigel Cunningham <ncunningham@linuxmail.org>
References: <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com> <1152353698.2555.11.camel@coyote.rexursive.com> <1152355318.3120.26.camel@laptopd505.fenrus.org> <20060708164312.GA36499@dspnet.fr.eu.org> <1152377246.3120.65.camel@laptopd505.fenrus.org> <20060708174928.GC36499@dspnet.fr.eu.org> <1152395189.27368.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152395189.27368.40.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 10:46:29PM +0100, Alan Cox wrote:
> The "free" OSS was superior to the proprietary one in pretty much every
> respect by the time ALSA had really got beyond being a neat alternative
> driver for a couple of chips.
> 
> So no I don't think so. ALSA still needs more dieting but the OSS API
> really didnt do the job.

Ok.  The current API looks better, but I agree I don't know the exact
timings.  Using ALSA is still hell-on-earth though.  And the actual
kernel interface is quite puke-worthy.

  OG.

