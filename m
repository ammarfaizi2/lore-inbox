Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWGaIcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWGaIcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWGaIcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:32:41 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:53185 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750700AbWGaIck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:32:40 -0400
Subject: Re: ipw3945 status
From: Kasper Sandberg <lkml@metanurb.dk>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Pavel Machek <pavel@suse.cz>, Theodore Tso <tytso@mit.edu>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <9e0cf0bf0607302306g435d73a1qbdab334c318c8dc2@mail.gmail.com>
References: <20060730104042.GE1920@elf.ucw.cz>
	 <20060730145305.GE23279@thunk.org> <20060730231251.GB1800@elf.ucw.cz>
	 <200607310123.06177.s0348365@sms.ed.ac.uk>
	 <1154308614.13635.49.camel@localhost>
	 <9e0cf0bf0607302306g435d73a1qbdab334c318c8dc2@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:32:19 +0200
Message-Id: <1154334740.13635.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 09:06 +0300, Alon Bar-Lev wrote:
> On 7/31/06, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > I entirely agree that this should not be merged, those will accept these
> > kindof things, can use intels out of tree driver.
> >
> > i sincerely hope for a forked/rewritten driver which does not depend on
> > closed userspace daemons.
> 
> I personally think that this also violates the GPL license...
> The GPL part cannot stand by it-self and require none GPLed component
> in order to make it work.
> 
> The fact that the regularity daemon work using external sysfs
> interface without linkage requirements does not escape derived work in
> this case.
i tend to agree, however if a generic interface was created for
"regulatory daemons" this may be different, but if what i hear is true,
the intel daemon does more than that, and then, well...

> 
> Best Regards,
> Alon Bar-Lev
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

