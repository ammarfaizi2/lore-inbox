Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUBPPds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUBPPdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:33:47 -0500
Received: from mail.eris.qinetiq.com ([128.98.1.1]:37705 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S265684AbUBPPdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:33:22 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Ryan Reich <ryanr@uchicago.edu>
Subject: Re: Speaker static, vanishes with APIC
Date: Mon, 16 Feb 2004 15:26:00 +0000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402150903010.1774@ryanr.aptchi.homelinux.org> <200402161512.12171.m.watts@eris.qinetiq.com> <Pine.LNX.4.58.0402160924150.15314@ryanr.aptchi.homelinux.org>
In-Reply-To: <Pine.LNX.4.58.0402160924150.15314@ryanr.aptchi.homelinux.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402161526.00864.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Mon, 16 Feb 2004, Mark Watts wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > > This is really trivial and I solved it anyway, but in all incarnations
> > > of 2.6 I have had static coming from my speakers shortly after boot. 
> > > It only lasts a few seconds and sounds as though someone were jiggling
> > > the plug in the sound card's socket.  It only happens right after boot.
> > >  Since I enabled Local APIC and IO-APIC it hasn't happened.
> >
> > Did you get a similar noise when shutting down?
> >
> > My other half has an AMD motherboard with onboard Via sound which gives a
> > burst of static when KDE 3.1 starts and another when it shuts down. All
> > other sound is fine. (Kernel 2.4.22)
> >
> > APIC's are disabled on this board...
>
> No, just when starting up.  It doesn't even need to be in KDE; in fact,
> I've never noticed it in KDE since I start in text mode and check my mail
> before starting X (you know how it's impossible to hold off checking mail).
>  Your problem sounds different since it's in 2.4, also, and I never saw
> this in 2.4.
>
> However, KDE and sound don't always agree, in my experience.  They can't
> even get their own sounds right sometimes; when shutting it down their
> "shutdown" tune is always cut off as the aRts server exits before it
> finishes playing the sound.  This, of course, is not static.

Ah well - one more thing to rule out :)

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAMOEIBn4EFUVUIO0RAraNAKCvioUiaRa9oAlj3cgcoQHonWMNBwCgv3R3
RUpPOYO7Mi9MMzxuiPu9rfk=
=Ukab
-----END PGP SIGNATURE-----

