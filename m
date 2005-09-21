Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVIUUQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVIUUQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVIUUQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:16:50 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:25876 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964805AbVIUUQt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:16:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ZPNSb2CB674wJeyEd4NtW3gSnoa26RyVl5xldt/YGSyZqkCzuJLiPctrk+cZMLc6sSwStGs97gSAcYaGXvEHY140MRiX5nguYUhxcoAAPzwNAxCLyi0PWzzu/Wo81WaTbGdqPINzlV2N21KZ1VaQpHLajGBSw3wNEbwA+9o3PgU=
Date: Wed, 21 Sep 2005 22:16:33 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, alexn@telia.com, torvalds@osdl.org, pavel@suse.cz,
       ebiederm@xmission.com, len.brown@intel.com, drzeus-list@drzeus.cx,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       masouds@masoud.ir, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-Id: <20050921221633.b3bf970b.diegocg@gmail.com>
In-Reply-To: <20050921114948.5b423109.akpm@osdl.org>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
	<20050921203505.32cc714d.diegocg@gmail.com>
	<20050921114948.5b423109.akpm@osdl.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 21 Sep 2005 11:49:48 -0700,
Andrew Morton <akpm@osdl.org> escribió:

> There is such a list - it's a great way to depress yourself while still
> half asleep.

Thanks. While we are at it, what do people thinks about this
very humble wiki page? (ie, does it have sense or I'd better remove it?):

http://wiki.kernelnewbies.org/wiki/LinuxChanges

I'm trying to do something useful, ie like:
http://wiki.dragonflybsd.org/index.php/DragonFly_Status

(yes, I also hate wikis, but if people knows of a better "colaborative
environment" crap which works even with lynx and using it is as easy
*cough* as writing text in a text form in lynx I'm all ears.
http://gcc.gnu.org/wiki/ is also a great example of why kernel could benefit
from using a wiki)
