Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVIUTzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVIUTzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVIUTzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:55:05 -0400
Received: from dvhart.com ([64.146.134.43]:60295 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751365AbVIUTzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:55:02 -0400
Date: Wed, 21 Sep 2005 12:54:58 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Diego Calleja <diegocg@gmail.com>
Cc: alexn@telia.com, torvalds@osdl.org, pavel@suse.cz, ebiederm@xmission.com,
       len.brown@intel.com, drzeus-list@drzeus.cx,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       masouds@masoud.ir, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-ID: <695600000.1127332498@flay>
In-Reply-To: <20050921114948.5b423109.akpm@osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com><20050921101855.GD25297@atrey.karlin.mff.cuni.cz><Pine.LNX.4.58.0509210930410.2553@g5.osdl.org><20050921173630.GA2477@localhost.localdomain><20050921203505.32cc714d.diegocg@gmail.com> <20050921114948.5b423109.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Morever bugme.osdl.org is severely underworked (acpi being a noteable
>> > exception) and Andrew has stepped in alot there too. Alot of bugs
>> > reported on the mailing list are only followed up by Andrew.
>> 
>> One of the things I'm _really_ missing from OSDL's bugzilla setup is a mailing
>> list (if there's one I've never heard about it) where all changes/new bugs/
>> random crap are posted.
> 
> There is such a list - it's a great way to depress yourself while still
> half asleep.
> 
> bugme-new@lists.osdl.org, but I'm not sure how one subscribes.  It doesn't
> appear at http://lists.osdl.org/mailman/listinfo/.   Martin?

http://lists.osdl.org/mailman/listinfo/bugme-new

But it's not "all changes/new bugs/random crap", it's "new bugs".
And it's all categories, but there's handy-dandy X- header fields
to filter on.

M.

