Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbTL0NWz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 08:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTL0NWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 08:22:55 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:38827 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264442AbTL0NWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 08:22:54 -0500
Date: Sat, 27 Dec 2003 14:22:13 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: GCS <gcs@lsc.hu>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Synaptics problems in -mm1
Message-ID: <20031227132213.GB10491@louise.pinerecords.com>
References: <20031224095921.GA8147@lsc.hu> <200312250411.55881.dtor_core@ameritech.net> <200312250413.32822.dtor_core@ameritech.net> <200312250414.58598.dtor_core@ameritech.net> <20031227113848.GA10491@louise.pinerecords.com> <20031227122417.GA20603@lsc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227122417.GA20603@lsc.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-27 2003, Sat, 13:24 +0100
GCS <gcs@lsc.hu> wrote:

> On Sat, Dec 27, 2003 at 12:38:48PM +0100, Tomas Szepe <szepe@pinerecords.com> wrote:
>
> > it seems one of the synaptics-related patches in 2.6.0-mm1 kills
> > off the pointer stick on my T40p.  2.6.0 vanilla works just fine
> > in that department.  Thought you might want to know.
>
> I had the same problems, but Dmitry provided two additional patches,
> which made my one working. Have you tried them? You can find them in the
> thread.

Unfortunately, the two patches from this thread don't solve
the mm1 problem I'm seeing, the stick keeps on resting. :)

> Ps:Somehow I know you, just don't know where - are you Hungarian?

Not really, it's just the name.

-- 
Tomas Szepe <szepe@pinerecords.com>
