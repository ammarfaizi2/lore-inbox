Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275267AbRIZP0V>; Wed, 26 Sep 2001 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275270AbRIZP0M>; Wed, 26 Sep 2001 11:26:12 -0400
Received: from mail.medav.de ([213.95.12.190]:39693 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S275266AbRIZP0E> convert rfc822-to-8bit;
	Wed, 26 Sep 2001 11:26:04 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Jeroen Ruigrok/Asmodai" <asmodai@wxs.nl>
Date: Wed, 26 Sep 2001 17:24:46 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.00
In-Reply-To: <20010926161613.V4995@daemon.ninth-circle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Comments on Andre's posting
Message-Id: <20010926143012.363B166DA@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As the developer of the OS/2 ATA/ATAPI drivers I'd like to add a few
comments.

On Wed, 26 Sep 2001 16:16:13 +0200, Jeroen Ruigrok/Asmodai wrote:

>3) Also, I have had contacts with Highpoint and Promise a long while now

I've learned Highpoint being very helpful but Promise being extremely
tight-lipped.

>   And quite frankly I have to laugh that you had to sign a NDA.

Good point!

>   Promise and Highpoint Technologies were quite willing to hand us the
>   documentation without an NDA.  We just felt it was the honourable
>   thing to do to not spread these docs.  Call it a matter of trust and
>   mutual respect.

So did I with manufacturer docs I was given.

>4) 48-bit addressing is already in the pipeline since Soren has the
>   official specifications from the t13 Technical Committee [which for
>   all I know, are freely downloadable].

True. There are no secrets.

>For some reason I cannot help but put big questionmarks behind Andre's
>exclamation that he was so quick to add ATA-100 after release of the
>information.  Congratulations to you Andre for being so quick, I hope
>your eagerness for speed doesn't in fact put stability in jeopardy.

Exactly. Andre: your Promise Ultra100 TX2 code is not correct. It
should not base vital decisions on contents of non-existent registers.

>Also, funny how you seem to funnel your anger or something to that
>extent into making sure everything gets licensed in such a way that
>others cannot use it.  If that is the free software spirit you envision
>then you scared me.  The only, reasonable, thing Soren asked for was
>proper attribution and credit of/for work he performed and work which
>was put under a BSD License.  To be honest, if a BSD (FreeBSD, NetBSD,
>OpenBSD) would've used GPLd code and filed off the copyright we would've
>seen a large rant about how unethical the BSD developers are, the pinko
>commies!

Well, I had to learn Andre is using code that I had developped and
given to him verbatim in his drivers without any credits. But I just
don't care. If it's to the benefit of the Linux users (and probably
even more) I'm happy with that.

My policy in helping other developers is something like tit-for-tat.
Let's share information, let's share experiences (there are so many
bugs/issues in the hardware to deal with), let's help each other!

Ciao,
  Dani

(The OS/2 ATA/ATAPI gal)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


