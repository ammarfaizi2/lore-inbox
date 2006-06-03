Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWFCVKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWFCVKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWFCVKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:10:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:31629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030361AbWFCVKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:10:46 -0400
X-Authenticated: #2308221
Date: Sat, 3 Jun 2006 23:11:06 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: wine-devel-request@winehq.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alsa sound vs OSS with wine and riven
Message-ID: <20060603211106.GA4452@zeus.uziel.local>
References: <4481E816.4090600@seclark.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <4481E816.4090600@seclark.us>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Sat, Jun 03, 2006 at 03:50:46PM -0400, Stephen Clark wrote:
> I have been working to get "Riven" the sequel to Myst to work with the
> latest wine from cvs on the latest FC5. It works and the sound is
> almost perfect with OSS, but is totally screwed up when I use ALSA, I
> don't know whether this is a WINE or Linux issue, so I am cross
> posting to both lists.

I had the same experience even with a little lower requirements wrt.
CPU performance - music player daemon (mpd) tends to eat a lot more
cycles when it is configured to use alsa style devices, but is pretty
low-impact when it talks to the OSS emulation provided by the very same
alsa drivers.

With wine and starcraft on my not-so-recent yet well maintained laptop
the difference in results was ultimate.

By the way, I still have to apply some scheduler tricks, makes me wonder
about wine's development during the past few years. I used to play
starcraft through wine on an ancient Pentium, and now a Mobile Pentium
III is almost choking on it. I wonder what is going on...

Kind regards,
Chris

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRIH66l2m8MprmeOlAQL/5Q//ccLq0WMc8g19eaCSxKB9eEMojNhwULRn
BqzWSHWpTWopMI3s2mVYGg+9hN54CIEga3Pkfgyn5PcL01ID/FGc6//Fh6QFNxZH
dDcZc77TmRwL+Y1W6JHus07YoCOTqAqMFN4RND+Ke1Zt2Mc3A+2YrWWWR1EESpxp
D+T8+KKhroXose8NMqT+wsEBgJgjNgiZR2sgVvWzEY/5KLoPhUJhg+RuDDM30nep
mXEkfGpUsctgwYl4GpuXzazQKtHVg+Zr9rXzFtikZE/iVSOYThMqZOneDSh7q+KE
zW6zGKrXPKcC8jNOxjDDfLyBwS62XSVAZ3NduMuqLQ5WuxL9xlP+yWDKNKapWf+w
YBe02tbo28LkTpeTsoOdtLyU1Qd4+Mgu95yQ7p6IJb0T162/Md9D6W79uqfbJlr5
B8OqWZi2Q8zUOqw+xpvnX/Kqzz/wpq+yTIx2nl9UYh70B2OzvKDIOxlpgdjPE/Mq
EnhWn9VD2vGPsd5IbBeFQ7ZBC0QExQQckXQKJLuNZB8a/O22DJd11AYlkiM1esOr
dynmx3O+Zuw7/KygLZmwLB1lTP90f7yMVPGhYbzJIWXx8O7UGk5HFcsQGJ6DVKk3
/dTuQDEN0TrVCRFKKxRvX+mP5wfHfQ3lJnxYYpZ0YdRVJI0ewsvaeiNBF5ySHqBO
onpXvb/IseU=
=1sWa
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

