Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbRASGmh>; Fri, 19 Jan 2001 01:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRASGm1>; Fri, 19 Jan 2001 01:42:27 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:32004 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S130539AbRASGmO>;
	Fri, 19 Jan 2001 01:42:14 -0500
Date: Fri, 19 Jan 2001 04:42:13 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
Message-ID: <20010119044213.A779@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com> <20010118020408.A4713@iname.com> <20010118121356.A28529@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010118121356.A28529@frednet.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 18 2001, Matthew Fredrickson wrote:
> BTW, are you having any trouble with your ps/2 mouse port in X?

	Like I said in the previous e-mail, I'm using right now an
	Asus A7V mobo with Linus' stock kernel 2.2.18 with André's
	patches.

	I'm using basically a Debian potato here with XFree86 3.3.6
	and a Microsoft Intellimouse (with IMPS/2 protocol) and
	everything seems to be working fine. Before my brand new 40GB
	Samsung HD died, I was using a more modified potato, including
	XFree86 4.0.1e (or 4.0.1f, I don't remember). Everything was
	also working fine with this older setup.

> On my new ASUS board, ps/2 mouse devices (just in X, gpm works fine)
> act a little crazy (random mouse movement, random clicking, etc.,
> except I'm not the one doing all the random movement).  I'm not sure
> what it is, though I do know it's not as bad once I upgraded from
> 2.2.18pre21 to 2.4.0.

	I usually only follow Alan's pre series when things are broken
	with the final releases, so I don't know about 2.2.18preX. I'm
	sorry that I can't help.

> I think I'm going to try using the mouse as a usb device and see if
> I still have trouble.

	Unfortunately, I have never ever seen a USB device, so I have
	no experience here to help you.

> Anyway, just wondering if you're seeing the same problem.

	No, but have you tried changing the mouse? I've had problems
	with a Matrox G400 AGP 16MB monohead that I purchased when I
	got my system. It did crash when X was running in Linux and
	FreeBSD (and many versions of X, for that matter), but under
	Windows it worked flawlessly.

	When I used Matrox's drivers with XFree86 4.x, it worked
	perfectly.  I changed my Matrox and now I'm using a new one
	under X 3.3.6 under potato (a stable platform that I use) and
	everything is fine).

	So, perhaps you could try changing your mouse?


	[]s, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
