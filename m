Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbTANIyN>; Tue, 14 Jan 2003 03:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbTANIyN>; Tue, 14 Jan 2003 03:54:13 -0500
Received: from atlas.inria.fr ([138.96.66.22]:42183 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S261847AbTANIyM>;
	Tue, 14 Jan 2003 03:54:12 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Organization: SEMIR - INRIA Sophia Antipolis
To: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: Bug report : i810_audio, compaq evo 410c, 2.4.20
Date: Tue, 14 Jan 2003 10:02:56 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Hugo Haas <hugo@larve.net>
References: <1042497413.1223.21.camel@sun>
In-Reply-To: <1042497413.1223.21.camel@sun>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301141002.56498.Nicolas.Turro@sophia.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le Lundi 13 Janvier 2003 23:36, Soeren Sonnenburg a écrit :
> > I have laptops here (compaq evo 410c) that freeze completely while
> > playing sound (using mpg123, for example). The crash is random, it may
> > freeze as soon as playback start of after a few minutes.
>
> All I can say is me too... It seems as if the sound card is doing irq
> sharing and strongly dislikes that... at least for me sound works for some
> seconds then starts to stutter and crashes somewhen (within 30sec) later.
>
> I was using kernel 2.4.18 (from debian woody).
>
> I also tried alsa but some behaviour.
>
> I saw that someone said he got it working, see:
>  http://larve.net/people/hugo/2002/12/evo410


I already contacted Hugo, in fact, he didn't manage to make the sound working 
either.

> But I could not find out how.
>
> It would be pretty nice if APM / ACPI worked for the evo ... did you
> try it yet ?

Nope


N. Turro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+I9JAty/HpgyBIboRAk/QAJ9mXgMY6dZJdoySupvGhwOfrPHoPQCg1SuL
teIziSbKZzmUdM6WqO+/N0Y=
=nvzU
-----END PGP SIGNATURE-----
