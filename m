Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277295AbRJJQAN>; Wed, 10 Oct 2001 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277296AbRJJP77>; Wed, 10 Oct 2001 11:59:59 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:28406 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S277295AbRJJP7x>; Wed, 10 Oct 2001 11:59:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Justin A <justin@bouncybouncy.net>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Date: Wed, 10 Oct 2001 17:37:40 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200110100358.NAA17519@isis.its.uow.edu.au> <20011010120009.851921E7C9@Cantor.suse.de> <20011010153653.Q726@athlon.random>
In-Reply-To: <20011010153653.Q726@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011010155953Z277295-760+23277@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Oktober 2001 05:25 schrieb Justin A:
> On Tue, Oct 09, 2001 at 08:36:56PM -0400, safemode wrote:
> > Heavily io bound processes (dbench 32)  still causes something as light as
> > an mp3 player to skip, though.   That probably wont be fixed intil 2.5,
> > since 
>
> What buffer size are you using in your mp3 player?  I have xmms set to
> 5000ms or so and it never skips.

OK, I'll give xmms with this buffer size a go, too.

> mpg321(esd or oss) also never skips no matter what I do,

Do you have link to the mpg321 (oss) version for me?

> but the original mpg123-oss will with even light load
> on the cpu/disk.

I get the hiccup with mpg123 and noatun (artsd, KDE-2.2.1).

>
> This is with 2.4.10-ac9+preempt on an athlon 700

Here with Linus tree.

-Dieter
