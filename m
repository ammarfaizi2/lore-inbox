Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVIUSvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVIUSvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVIUSvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:51:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750750AbVIUSvK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:51:10 -0400
Date: Wed, 21 Sep 2005 11:49:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Diego Calleja <diegocg@gmail.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Cc: alexn@telia.com, torvalds@osdl.org, pavel@suse.cz, ebiederm@xmission.com,
       len.brown@intel.com, drzeus-list@drzeus.cx,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       masouds@masoud.ir, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-Id: <20050921114948.5b423109.akpm@osdl.org>
In-Reply-To: <20050921203505.32cc714d.diegocg@gmail.com>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
	<20050921203505.32cc714d.diegocg@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja <diegocg@gmail.com> wrote:
>
> El Wed, 21 Sep 2005 19:36:30 +0200,
> Alexander Nyberg <alexn@telia.com> escribió:
> 
> > Morever bugme.osdl.org is severely underworked (acpi being a noteable
> > exception) and Andrew has stepped in alot there too. Alot of bugs
> > reported on the mailing list are only followed up by Andrew.
> 
> One of the things I'm _really_ missing from OSDL's bugzilla setup is a mailing
> list (if there's one I've never heard about it) where all changes/new bugs/
> random crap are posted.

There is such a list - it's a great way to depress yourself while still
half asleep.

bugme-new@lists.osdl.org, but I'm not sure how one subscribes.  It doesn't
appear at http://lists.osdl.org/mailman/listinfo/.   Martin?
