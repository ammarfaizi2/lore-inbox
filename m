Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUAHQYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUAHQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:24:09 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:36282 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S265515AbUAHQYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:24:01 -0500
Date: Thu, 08 Jan 2004 11:23:49 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <20040108122916.GA72001@dspnet.fr.eu.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3FFD8415.9000502@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enigB8CC8934A63C29DAF0B98D72;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <3FFB12AD.6010000@sun.com>
 <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
 <3FFC8E5B.40203@sun.com> <3FFC8E5B.40203@sun.com>
 <20040108122916.GA72001@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8CC8934A63C29DAF0B98D72
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Olivier Galibert wrote:
> On Wed, Jan 07, 2004 at 05:55:23PM -0500, Mike Waychison wrote:
> 
>>Yes, an 'ls' actually does an lstat on every file.
> 
> 
> I guess you haven't met the plague called color-ls yet.  Lucky you.
> 
> Most modern file browsers also seem to feel obligated to follow
> symlinks to check whether they're dangling.  A mis-click on "up" when
> you're on your home directory could cause a beautiful mount-storm.

Why would any file browser or even ls feel compelled to 'stat' something 
right after an 'lstat' says it is not a symbolic link though?

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------enigB8CC8934A63C29DAF0B98D72
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//YQZdQs4kOxk3/MRAh5TAJ9o0dcaS8VFsPdlxfY77GuGIXO20gCeOmb5
9qtkXmyjgPDQpRAmh7rxekk=
=b5rQ
-----END PGP SIGNATURE-----

--------------enigB8CC8934A63C29DAF0B98D72--

