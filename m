Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270831AbTHOUf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270833AbTHOUf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:35:27 -0400
Received: from main.gmane.org ([80.91.224.249]:37054 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270831AbTHOUfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:35:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Centrino support
Date: Fri, 15 Aug 2003 13:35:17 -0700
Message-ID: <m2oeyq3bi2.fsf@tnuctip.rychter.com>
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Exp7zN4QUesP6u+9f4ZZhPhqvV0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Bryan" =3D=3D Bryan O'Sullivan <bos@serpentine.com>:
 Bryan> On Fri, 2003-08-15 at 11:13, Jan Rychter wrote:
 >> Well, that was almost 5 months ago. So I figured I'd ask if there's
 >> any progress -- so far the built-in wireless in my notebook still
 >> doesn't work with Linux and the machine is monstrously power-hungry
 >> because Linux doesn't scale the CPU frequency.

 Bryan> Intel shows no inclination to release Centrino wireless drivers
 Bryan> for Linux.  There have been vague insinuations that this is due
 Bryan> to excessive software controllability, but no public
 Bryan> explanations have been given, beyond "we're not doing it at this
 Bryan> moment".

 Bryan> If you want built-in wireless in the nearish term, you'll have
 Bryan> to get a supported MiniPCI card and replace your Centrino card.

That's what I find extremely annoying. Especially in the context of
Intel's trumpeted announcements about support for Linux (see the URL in
my previous E-mail). I mean, you either support Linux, or you
don't. Intel announced that support is coming and then hasn't delivered
it.

This is offtopic on this list, but frankly, I'm surprised why RedHat (or
any other Linux company for that matter) hasn't filed an unfair
competition suit yet. Intel's approach basically favors Microsoft over
other companies by giving them a year or so headway before anybody else
has a chance of getting the hardware supported. That surely sounds like
an unfair practice to me.

 Bryan> As far as CPU is concerned, if you're using recent 2.5 or 2.6
 Bryan> kernels, there's Pentium M support in cpufreq.  Jeremy
 Bryan> Fitzhardinge has written a userspace daemon that varies the
 Bryan> Pentium M CPU frequency in response to load.

I keep dreaming about the day when I'll be able to have a modern laptop
with a stable Linux kernel. As for now, it has taken me (on one of my
laptops) about 1.5 years to get to a point where 2.4 works, most of my
hardware works, and software suspend (pretty much a requirement for
laptops) works. I'm not about to give that up easily, so I'm not that
eager to jump to 2.5/2.6.

Question time:

1. Will cpufreq make it into the standard 2.4 kernels?
2. If not, will Alan incorporate swsusp into -ac kernels? (given that
   -ac kernels seem to have cpufreq included)
3. Where does one get 2.4 cpufreq?

thanks,
=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/PUQGLth4/7/QhDoRAkrXAKDcvBdOeO2/q+OTsgAPwFo9m4sn7wCdGwa1
RzNfrFQdRMDAs9VUziI/Pek=
=dsif
-----END PGP SIGNATURE-----
--=-=-=--

