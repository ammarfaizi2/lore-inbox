Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVBYG4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVBYG4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 01:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVBYG4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 01:56:39 -0500
Received: from h80ad24f0.async.vt.edu ([128.173.36.240]:65031 "EHLO
	h80ad24f0.async.vt.edu") by vger.kernel.org with ESMTP
	id S262635AbVBYG4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 01:56:36 -0500
Message-Id: <200502250656.j1P6uLTS022935@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Greg Folkert'" <greg@gregfolkert.net>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Greg's Decree! (was Re: Linus' decrees?) 
In-Reply-To: Your message of "Thu, 24 Feb 2005 17:08:33 EST."
             <002201c51abd$712cf500$294b82ce@stuartm> 
From: Valdis.Kletnieks@vt.edu
References: <002201c51abd$712cf500$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109314581_3960P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Feb 2005 01:56:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109314581_3960P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Feb 2005 17:08:33 EST, Stuart MacDonald said:

> So what I'm wondering is, is there a location on the net where Linus'
> statements about how the kernel is to be are collected? ie, Where the
> above statements could all be found, with cites.

Your kernel source came with 3 files in the Documentation/ directory:
CodingStyle, SubmittingDrivers, and SubmittingPatches.  That's probably
as close to an official "how the kernel is to be" as you will find.

Remember that Linus has *always* reserved the right to change his mind
if a "sufficiently good" idea came along.  So it's not as much a "The Emperor
Penguin Has Decreed" as "Nobody's made a sufficiently convincing case to Linus".
(And I've never seen Linus claim to be totally consistent on what qualifies as
"sufficiently" - he can be a lot more stubborn about some things and flexible on
on others)

And remember that Linus has a source tree, but so do many others. There's
been lots of stuff that's made appearances elsewhere - the -mm tree has had
enough different schedulers that totally ripped out the innards of something
as basic as the scheduler that a 'plugsched' patch showed up.  I'm personally
convinced we've not seen the last of the reiser4 "file as directory" concept, and
that somebody will do a sane version at the VFS level where it belongs.  There's
a whole bunch of other in-flight code that would be totally against a "how the
kernel shall be" document of just 2 years ago.

Another thread mentioned the kernelnewbies fortunes file:
http://www.kernelnewbies.org/kernelnewbies-fortunes.tar.gz

That's probably as close to an official document as you're likely to find.
And the fact that it's in the format of a fortunes file says a lot about
the mindset of the kernel hacking community, in a Zen koan sort of way.

--==_Exmh_1109314581_3960P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCHswVcC3lWbTT17ARAhD4AJ9KPWqOZSwqBRgB391u2cuFJDi6+ACgvoeU
pbsIfSlk9PW8J7BOrfbulGQ=
=4NVs
-----END PGP SIGNATURE-----

--==_Exmh_1109314581_3960P--
