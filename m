Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWD1Pt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWD1Pt3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWD1Pt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:49:29 -0400
Received: from web36603.mail.mud.yahoo.com ([209.191.85.20]:39776 "HELO
	web36603.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030439AbWD1Pt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:49:28 -0400
Message-ID: <20060428154928.40409.qmail@web36603.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Fri, 28 Apr 2006 08:49:27 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
To: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Andi Kleen <ak@suse.de>,
       Ken Brush <kbrush@gmail.com>, Neil Brown <neilb@suse.de>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <1146229328.11817.73.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> But this is a temporary situation, until we have the
> infrastructure and
> tools developed to make MAC truly manageable by
> typical end users.  Not
> an inherent problem.

Oh come on! I've been hearing that saw continueously
since 1987. Mandatory MAC (as opposed to targeted MAC)
is hard on sysadmins. It will remain so. SELinux,
Trusted Solaris, Trusted IRIX, and anyone else are all
a pain in the bum and will remain so. Tools are going
to help only to a limited extent, they never make all
the pain go away. Smarter people than I have been
working on the problem for 20 years and I believe that
it's safe to say there is no magic wand that will
make the problems all go away.

I like MAC. I like the Iron Fist approach to software
security. I just don't believe that there's a glove
with velvet thick enough to please the masses.


Casey Schaufler
casey@schaufler-ca.com
