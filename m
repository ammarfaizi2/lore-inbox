Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293758AbSCFSdX>; Wed, 6 Mar 2002 13:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293756AbSCFSc4>; Wed, 6 Mar 2002 13:32:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:48494 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293757AbSCFSci>;
	Wed, 6 Mar 2002 13:32:38 -0500
Date: Wed, 6 Mar 2002 19:32:18 +0100
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
        Greg KH <greg@kroah.com>
Cc: vojtech@suse.cz
Subject: Re: [2.5.5-dj2] USB keyboard strangeness and ALSA error
Message-Id: <20020306193218.4bec28ca.sebastian.droege@gmx.de>
In-Reply-To: <20020305011604.G23524@suse.de>
In-Reply-To: <20020304211949.26f188ac.sebastian.droege@gmx.de>
	<20020304223530.GA5280@kroah.com>
	<20020305011604.G23524@suse.de>
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="XCghHCm=.rme09lb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--XCghHCm=.rme09lb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2002 01:16:04 +0100
Dave Jones <davej@suse.de> wrote:

> On Mon, Mar 04, 2002 at 02:35:31PM -0800, Greg KH wrote:
>  > > I've following problems with 2.5.5-dj2:
>  > > If I try to enable numlock I get this message: hid-core.c: control queue full
>  > > and the numlock LED doesn't shine but numlock is enabled
>  > > This is on a USB keyboard (Cherry xyz... the one with included USB hub)
>  > > While booting I get this message: hid-core.c: ctrl urb status -32 received
>  > 
>  > Can you please try 2.5.6-pre2 and let us know if you still have the USB
>  > problem with that kernel?
> 
>  My money is on it being ok. -dj has vojtech's various new input layer
>  trickery, which I'm suspecting is the real cause of the problem.
Yes right... 2.5.6-pre2 doesn't compile properly but 2.5.5 doesn't have this problem
If it's really important to test it with 2.5.6-pre2 I'll try it again this evening or tomorrow

Bye
--XCghHCm=.rme09lb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8hmC1e9FFpVVDScsRAmMDAJ9l+Mp/uyosb+WhCc6hW/H7zxqWUgCfXNBC
dkah9Ejqymulv7A81ykak1A=
=vit0
-----END PGP SIGNATURE-----

--XCghHCm=.rme09lb--

