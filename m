Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWGHTaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWGHTaN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWGHTaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:30:12 -0400
Received: from mailhost.terra.es ([213.4.149.12]:10423 "EHLO
	csmtpout1.frontal.correo") by vger.kernel.org with ESMTP
	id S964966AbWGHTaL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:30:11 -0400
Date: Sat, 8 Jul 2006 21:36:06 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: "Alon Bar-Lev" <alon.barlev@gmail.com>
Cc: arjan@infradead.org, galibert@pobox.com, pavel@ucw.cz, avuton@gmail.com,
       linux-kernel@vger.kernel.org, jan@rychter.com,
       suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-Id: <20060708212935.6282c36f.grundig@teleline.es>
In-Reply-To: <9e0cf0bf0607081001x6ccbd080sbe64118965d90838@mail.gmail.com>
References: <20060627133321.GB3019@elf.ucw.cz>
	<20060707215656.GA30353@dspnet.fr.eu.org>
	<20060707232523.GC1746@elf.ucw.cz>
	<200607080933.12372.ncunningham@linuxmail.org>
	<20060708002826.GD1700@elf.ucw.cz>
	<m2d5cg1mwy.fsf@tnuctip.rychter.com>
	<1152353698.2555.11.camel@coyote.rexursive.com>
	<1152355318.3120.26.camel@laptopd505.fenrus.org>
	<20060708164312.GA36499@dspnet.fr.eu.org>
	<1152377246.3120.65.camel@laptopd505.fenrus.org>
	<9e0cf0bf0607081001x6ccbd080sbe64118965d90838@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 8 Jul 2006 20:01:30 +0300,
"Alon Bar-Lev" <alon.barlev@gmail.com> escribió:

> Anyway... Unlike the ALSA case, people opens bugs on suspen2 (The new
> system) and not on swsusp, since Nigel is much more receptive, and
> because of the large user community suspend2 works much better.

Pavel has been working to make suspend work as hard as Nigel and others,
don't pretend the contrary because it's not true. They fixed swsusp so
that now it works for me, and they're actively improving it (which is
why they still deserve their place in the MAINTAINERS file, if it was
undermaintained or uswsusp would be a really bad idea I could
understand it, but it's not the case) every day where it doesn't
works (just as Nigel with suspend2).
