Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTF2ULt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbTF2ULt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:11:49 -0400
Received: from main.gmane.org ([80.91.224.249]:43198 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263915AbTF2UHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:07:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: 2.4.21 USB oops
Date: Sun, 29 Jun 2003 13:22:16 -0700
Message-ID: <m2brwg1vnr.fsf@tnuctip.rychter.com>
References: <m2smpu73du.fsf@tnuctip.rychter.com> <20030628164748.GB1619@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Portable Code, linux)
Cancel-Lock: sha1:XGZo1Bl5rbxo2JLaPnDwzsn4gSI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Greg" =3D=3D Greg KH <greg@kroah.com> writes:
 Greg> On Sat, Jun 28, 2003 at 06:11:57AM -0700, Jan Rychter wrote:
 >> I got the following oops after doing "modprobe uhci". The system
 >> froze completely about 30 seconds after that.
 >>
 >> Before that, I have unloaded uhci, loaded usb-uhci, and then
 >> unloaded usb-uhci again. This could be relevant.

 Greg> So if you just load the uhci driver everything works?  Did you
 Greg> have any usb devices connected?

Yes, I normally use uhci and do not have any problems. I might have had
a device connected (a bluetooth USB adapter), but I am not sure now.

Should I try to reproduce this, or is the trace sufficient?

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+/0p5Lth4/7/QhDoRAoDyAJ9oPVcr0YSuhypjU9xvQ52TL+KnfACg0Sdq
fLFfJegPrNgQg2Ga/Hvrpcg=
=InRu
-----END PGP SIGNATURE-----
--=-=-=--

