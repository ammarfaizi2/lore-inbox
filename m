Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVFBVo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVFBVo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBVo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:44:56 -0400
Received: from mout1.freenet.de ([194.97.50.132]:26084 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261433AbVFBVba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:31:30 -0400
Date: Thu, 2 Jun 2005 23:31:20 +0200
From: Michelle Konzack <linux4michelle@freenet.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] mailing list management
Message-ID: <20050602213120.GA3535@freenet.de>
References: <429D8A3A.8000304@poczta.fm> <20050601102211.GR2417@lug-owl.de> <429D8E96.4010908@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <429D8E96.4010908@poczta.fm>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings Michelle.
X-Disclaimer-DE: Eine weitere Verwendung oder die Veroeffentlichung dieser Mail oder dieser Mailadresse ist nur mit der Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux samba3.private 2.4.27-1-386
X-Uptime: 23:21:17 up 11 days,  9:08,  4 users,  load average: 1.49, 1.07, 0.95
X-Homepage: http://www.debian.tamay-dogan.homelinux.net/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 2005-06-01 12:31:50, schrieb Lukasz Stelmach:
> Jan-Benedict Glaw napisa?(a):

> > Please just configure your email client
> > correctly.
> ^^^^^^^^^^^^
> That is?
>=20
> Well I might use "Reply to all" but then for example you would receive
> two copies of this email. One in your private inbox and the other in the
> list's box. Is this correct?

No, because I know this stupid people sending me every day tonns of
unrequested CCs which make relpying harder and I have a procmailfilter
which do:

  __( '/home/michelle.konzack/.procmailrc' )____________________________
 /
| PATH=3D$HOME/bin:/usr/bin:/bin:
| MAILDIR=3D$HOME/Maildir
| DEFAULT=3D$MAILDIR/.SPAM/
<snip>
| INCLUDERC=3D$HOME/.procmail/FLT_cced

which is:

      __( '/home/michelle.konzack/.procmail/FLT_cced' )________
     /
    | :0
    | * ^Envelope-to:.*(linux4michelle|sun4michelle)@freenet.de
    | {
    <snip>
    |     :0
    |     * ^TO_.*(linux-kernel@vger.kernel.org|<snip>)
    |     .ATTENTION.FLT_cced/
    |    =20
    |     :0
    |     * ^TO_.*(lists.debian.org)
    |     .ATTENTION.FLT_cced/
    | }
     \_________________________________________________________

| INCLUDERC=3D$HOME/.procmail/ML_linux

where I have:

      __( '/home/michelle.konzack/.procmail/ML_linux' )________
     /
    | :0
    | * ^X-Mailing-List:.*(linux-kernel@vger.kernel.org|<snip>)
    | {
    |     :0
    |     * ^X-Mailing-List:.*(linux-kernel@vger.kernel.org)
    |     .ML_linux.linux-kernel@vger.kernel.org/
    <snip>
    | }
     \_________________________________________________________

| :0
| * ^To:.*(linux4michelle|<snip>)@freenet.de
| {
|   :0
|   * ^From:.*(web-tools@nas.nasa.gov)
|     * ^To:.*(linux4michelle)
|     .Linux.Astronomie_NASA/
|  =20
|   :0
|   * ^To:.*(linux4michelle@freenet.de)
|   .Linux/
| }
 \______________________________________________________________________

Greetings
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCn3qoC0FPBMSS+BIRAruTAJ9husN3s5QHRkqPYk48nmK+PZFIhgCg17SG
zN49U6X3apANV3GRIqqUdlY=
=hcQi
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
