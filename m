Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVAQHsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVAQHsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAQHro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:47:44 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6329 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262720AbVAQHra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:47:30 -0500
Message-ID: <41EB6D94.9040500@comcast.net>
Date: Mon, 17 Jan 2005 02:47:32 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Audit Project?
References: <41EB6691.10905@comcast.net> <20050117073217.GC13827@redhat.com>
In-Reply-To: <20050117073217.GC13827@redhat.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Damn that sucks.  I think stable releases need every patch audited
before they get Linus' blessing, and unfortunately it seems we don't
have the required 150+ people jumping up to volunteer.  :(

Yes I have unrealistic goals.  Sane, but unrealistic.  Perhaps
collaboration with the major distributions to volunteer developers to do
the auditing?  We need SOMETHING; there's been too much line noise here
about kernel security holes.  Whether this is new or people are just
noticing and overreacting now, it's still not good.

Unfortunately, "Something" requires manpower.  Manpower requires people
who aren't busy doing other things, like improving preemptiveness,
rewriting the VM system, enhancing the scheduler, or writing new
drivers.  And unfortunately, not only is everyone busy with all of that;
but we NEED all of that too.

Well, maybe you can't start up a group now, or implement audit policy;
but perhaps the invitation needs to be there.  I see there are no -audit
or -security lists on vger; perhaps somebody should start a
linux-kernel-audit@vger list just to get the ball rolling.  If it grows
big enough, then you can consider some policy about having the changes
audited FIRST before releasing; for now that's just not feasible.

Dave Jones wrote:
> On Mon, Jan 17, 2005 at 02:17:37AM -0500, John Richard Moser wrote:
>  > -----BEGIN PGP SIGNED MESSAGE-----
>  > Hash: SHA1
>  > 
>  > Is there an official Linux Kernel Audit Project to actively and
>  > aggressively security audit all patches going into the Linux Kernel, or
>  > do they just get a cursory scan for bugs and obvious screwups?
> 
> There were at least two such projects that crashed and burned
> that I recall, the last was "active" about 3 years ago, and
> accomplished very little.
> 
> 		Dave
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB622KhDd4aOud5P8RAnJcAJ4n9Pt6JbYRlu2cmSTt91xM7IO8fACffUA7
rzoWMpWXPrNUxk+v/fDNeN8=
=Mxal
-----END PGP SIGNATURE-----
