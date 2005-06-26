Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVFZAq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFZAq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 20:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVFZAq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 20:46:27 -0400
Received: from mxout03.versatel.de ([212.7.152.117]:52874 "EHLO
	mxout03.versatel.de") by vger.kernel.org with ESMTP id S261288AbVFZApQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 20:45:16 -0400
Message-ID: <42BDFA8E.6060608@web.de>
Date: Sun, 26 Jun 2005 02:45:02 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050617)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de> <87fyv8h80y.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87fyv8h80y.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=6B99E3A5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4215EEB3A6EEE9136AA59BA7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4215EEB3A6EEE9136AA59BA7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hubert Chan schrieb:
> How about something of the form "nikita-955(file:line)"?  Or the
> reverse: "file:line(nikita-955)".  Would that keep everyone happy?
> 
Damn, I was wondering how long it would take until someone would come up 
with a compromise solution ; ) Compromises everywhere will lead to 
nowhere, I've learned that the hard way. But this is really not a major 
issue, so let's not make a showstopper out of this one and the likes.

For what I know about the whole inclusion discussion until now, there's 
been a whole lot of flamewar chickenshit so far. Considering that I have 
no FS developing abilities whatsoever, I'm pretty pissed at people who 
do know better in their field and should know better than waste their 
time on discussions other than constructive ones.

Get the personal bullshit out of the way, everyone, please! Get in touch 
and work out your differences in a productive manner. If every 
interesting yet at first intrusive extension to the kernel causes as 
much kindergarten as this one, where will we end up? Stagnation sucks, 
yet good progress is sometimes slow-paced...

Peace, everyone!
Chris
(hardcore, not hippie)


--------------enig4215EEB3A6EEE9136AA59BA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr36kl2m8MprmeOlAQIRxA//fH196LTXn2kr2C76lQ3na6Mbw8H6vZU9
6GSg1GZaNr54/HlRIfns80Il4cZvIh4GdemSbKQXq1YUMY9Aia2UA7rnMplsriSd
n12HLD65eDo3SFhh+GT2VsuvjJs08O2y/OJqqwcGCcWpD3AMcx5xm9vnZ3MgDk3R
dirGLi6lxxArF0mSaZCP9fSLcNXz46PaSzYH6K3MeFwdih/Rq43tnjGlaUIv+9UP
POtXmnGICLOeRRKhbKKbdDo17TPl/0ruVacL8TI4p1ru2T5oX2T7kukCzscbg+nx
Vl0hj8ufRiu/z55wPesVza+JiZh5Ph7SvnHFeVDe7e+9V4D6iaGRGojKffPYLEYe
9xzCo49EFhTieDsw2K48fPWhy+/t95458sMgNoIwmpMkZHbOl4HpPEM6L/+L9lTR
j8rcAK5YhWQYVD3MHgCKiQS93b0WEq0S/bt7un+bTXvpIuqjwBld59Jn/X17LQxt
5KZZ37zwyndYvAIO/0tRTiFhL3TFpl4nOAu9Tg5qeXgBbcaeFTUc9IzaxGeZmb4l
ghrOJuGfYdINeBl++RIyU+bI2H/gBMKn+nTMlLsaF37/xVBsU7euKxn2ttrpZuSA
14DtkY2gR1W7O8BHOSZCjAX/sBDRHOv/9/AoVUwy7vVhE7KnxAPiOZ2fNP3NWcIb
Ld/nuKgQoEk=
=m+Po
-----END PGP SIGNATURE-----

--------------enig4215EEB3A6EEE9136AA59BA7--
