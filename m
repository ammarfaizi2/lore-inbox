Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTL0Mir (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 07:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTL0Mir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 07:38:47 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:38795 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S263751AbTL0Miq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 07:38:46 -0500
Date: Sat, 27 Dec 2003 13:24:17 +0100
From: GCS <gcs@lsc.hu>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Synaptics problems in -mm1
Message-ID: <20031227122417.GA20603@lsc.hu>
References: <20031224095921.GA8147@lsc.hu> <200312250411.55881.dtor_core@ameritech.net> <200312250413.32822.dtor_core@ameritech.net> <200312250414.58598.dtor_core@ameritech.net> <20031227113848.GA10491@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20031227113848.GA10491@louise.pinerecords.com>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 12:38:48PM +0100, Tomas Szepe <szepe@pinerecords.com> wrote:
> it seems one of the synaptics-related patches in 2.6.0-mm1 kills
> off the pointer stick on my T40p.  2.6.0 vanilla works just fine
> in that department.  Thought you might want to know.
 I had the same problems, but Dmitry provided two additional patches,
which made my one working. Have you tried them? You can find them in the
thread.

Cheers,
GCS
Ps:Somehow I know you, just don't know where - are you Hungarian?
