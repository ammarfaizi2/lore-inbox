Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755891AbWKQUke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbWKQUke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbWKQUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:40:34 -0500
Received: from lug-owl.de ([195.71.106.12]:37853 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1755892AbWKQUkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:40:32 -0500
Date: Fri, 17 Nov 2006 21:40:30 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Remove old address from lkkbd.c
Message-ID: <20061117204030.GR26875@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+S4DbcR7QPeSsP0V"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+S4DbcR7QPeSsP0V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please pull from
git://git.kernel.org/pub/scm/linux/kernel/git/jbglaw/vax-linux.git fixes4li=
nus

You'll get:

 drivers/input/keyboard/lkkbd.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)


commit 1d08811d0c05cd54a778f45588ec22eee027ff89
Author: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date:   Fri Nov 17 10:32:04 2006 +0100

    lkkbd: Remove my old snail-mail address
   =20
    I moved to a different town and my old snail-mail address is invalid
    now.  Also, there's no need at all to have any address like that in
    the sources, so remove it completely.
   =20
    Signed-off-by: Jan-Benedict Glaw <jbglaw@lug-owl.de>


diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
index 708d5a1..979b93e 100644
--- a/drivers/input/keyboard/lkkbd.c
+++ b/drivers/input/keyboard/lkkbd.c
@@ -59,11 +59,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so either by
- * email or by paper mail:
- * Jan-Benedict Glaw, Lilienstra=C3=9Fe 16, 33790 H=C3=B6rste (near Halle/=
Westf.),
- * Germany.
  */
=20
 #include <linux/delay.h>


MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:         Alles wird gut! ...und heute wirds schon ein bi=C3=9F=
chen besser.
the second  :

--+S4DbcR7QPeSsP0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFXh49Hb1edYOZ4bsRAtqqAJ9P7ONUVswEeLtM0jwvVfsXzB9JQQCfU57g
0qb//NOT7UruZE0g+N4crms=
=2rMT
-----END PGP SIGNATURE-----

--+S4DbcR7QPeSsP0V--
