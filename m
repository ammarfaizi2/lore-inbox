Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWAWCLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWAWCLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWAWCLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:11:04 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:51593 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751388AbWAWCLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:11:03 -0500
Message-ID: <43D43AF3.1090801@comcast.net>
Date: Sun, 22 Jan 2006 21:09:55 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
CC: Diego Calleja <diegocg@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net>	<20060122093144.GA7127@thunk.org> <20060122205039.e8842bae.diegocg@gmail.com> <43D42AA2.6040106@comcast.net> <43D42CCE.9010709@FreeBSD.org>
In-Reply-To: <43D42CCE.9010709@FreeBSD.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Suleiman Souhlal wrote:
> John Richard Moser wrote:
> 
>> Yeah, the huge TB fsck thing became a problem.  I wonder still if it'd
>> be useful for small vfat file systems (floppies, usb drives); nobody has
>> led me to believe it's definitely feasible to not corrupt meta-data in
>> this way.
> 
> 
> Please note that you don't *HAVE* to run fsck at every reboot. All
> background fsck does is reclaim unused blocks.
> 

Duly noted, now can you answer my question?

> -- Suleiman
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD1DryhDd4aOud5P8RAjiwAJ9xH5V/W2i5U/oVzT6AjdmBVk5+iwCfWD2j
JzBRinqiqDd/rIQFkS9QIsQ=
=SlOI
-----END PGP SIGNATURE-----
