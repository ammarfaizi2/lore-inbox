Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263851AbRF0QPD>; Wed, 27 Jun 2001 12:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbRF0QOx>; Wed, 27 Jun 2001 12:14:53 -0400
Received: from pD4B9D66C.dip.t-dialin.net ([212.185.214.108]:2310 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S263766AbRF0QOo> convert rfc822-to-8bit;
	Wed, 27 Jun 2001 12:14:44 -0400
Message-ID: <3B3A0631.1E5FA84@baldauf.org>
Date: Wed, 27 Jun 2001 18:13:37 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM deadlock
In-Reply-To: <Pine.LNX.4.21.0106271010530.1331-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

> On Wed, 27 Jun 2001, Xuan Baldauf wrote:
>
> > Hello,
> >
> > I'm not sure wether this is a reiserfs bug or a kernel bug,
> > so I'm posting to both lists...
> >
> > My linux box suddenly was not availbale using ssh|telnet,
> > but it responded to pings. On console login, I could type
> > "root", but after pressing "return", there was no reaction,
> > and pressing keys did not result in writing them on the
> > screen.
> >
> > "Emergency sync" and "Remount R/O" did not have any
> > response.
> >
> > That's why I pressed Alt+SysRq+P 5 times and wrote all stack
> > traces (without registers) onto paper. After that, I pressed
> > Alt+SysRq+T and also wrote 3 long stack traces (others were
> > available too, but too short) down.
>
> Xuan,
>
> Are you using kiobuf IO ?

I do not exactly know what kiobuf-IO is, so I suppose: no.

Xuân.


