Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752712AbVHGUre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbVHGUre (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbVHGUre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:47:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:37517 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752712AbVHGUrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:47:33 -0400
X-Authenticated: #3439220
From: Martin Maurer <martinmaurer@gmx.at>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Fw: Re: Elitegroup K7S5A + usb_storage problem
Date: Sun, 7 Aug 2005 22:47:40 +0200
User-Agent: KMail/1.7.2
Cc: martin.maurer@email.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, PeteZaitcev <zaitcev@redhat.com>
References: <Pine.LNX.4.44L0.0508071400290.32668-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0508071400290.32668-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2327875.BEcikRRQI1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508072247.43916.martinmaurer@gmx.at>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2327875.BEcikRRQI1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday, 7. August 2005 20:08, Alan Stern wrote:
> On Sun, 7 Aug 2005 martin.maurer@email.de wrote:
> > Hi Alan,
> >
> > no. the stick doesn't have a write protection switch.
> > Once when i tried to copy a file to the mp3 player i got a new file the=
re
> > on remount, but it consisted of incorrect data. (so writing seemed to be
> > possible and just went wrong) (in that case the fat seemed to be damaged
> > after i had tried this, so that windows wasn't able to read it correctly
> > any more.
> > (formatting from the mp3 players menu helped)
>
> Well, perhaps the device isn't consistently writing data to the
> correct locations.
>
> > greetings
> > Martin
> >
> > PS: just as an info - i sent a usbmon trace to Pete Zaitcev today, shou=
ld
> > I send it to you too?
>
> Pete is quite as competent at solving this kind of problem as I am.  And
> he knows the ub driver much better, so I'm happy to bow out and let him
> worry about it!  :-)
>
> Just out of curiosity, if you plug the player into a Windows system
> without installing any special drivers first, will Windows be able to read
> and write files okay?  If it can, a USB packet trace may give Pete a clue
> as to where to look.
as far as i recall i didnt install any special drivers for my win 2k and wi=
n=20
xp systems. (i got this mp3 player quite a while now...)
How would I do such an packet trace ?


>
> Alan Stern
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart2327875.BEcikRRQI1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC9nNvXHsqb5Up6wURAnBpAJ9SoMfqnDuLF4yNima/HKa/bRmXcgCfYFSB
F3dORvr5I5anSkCWCXnrwYg=
=LJ0Z
-----END PGP SIGNATURE-----

--nextPart2327875.BEcikRRQI1--
