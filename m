Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTBKQmQ>; Tue, 11 Feb 2003 11:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbTBKQmQ>; Tue, 11 Feb 2003 11:42:16 -0500
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:46608 "EHLO
	sirius.nix.badanka.com") by vger.kernel.org with ESMTP
	id <S267284AbTBKQmP>; Tue, 11 Feb 2003 11:42:15 -0500
Message-Id: <200302111652.h1BGq0PY067795@sirius.nix.badanka.com>
Date: Tue, 11 Feb 2003 17:51:09 +0100
From: Henrik Persson <nix@socialism.nu>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
In-Reply-To: <20030211154449.GA2252@k3.hellgate.ch>
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com>
	<20030211154449.GA2252@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.AGpp2J:AW?tC9m"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.AGpp2J:AW?tC9m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2003 16:44:49 +0100
Roger Luethi <rl@hellgate.ch> wrote:

RL> The patch attached below will definitely solve some of the problems
RL> you're seeing (e.g. "excessive collisions" on a switch). Feedback
RL> welcome. As I've explained in previous postings, the current event
RL> handling is pretty broken.
RL> 
RL> I have nailed down a number of problems even this patch doesn't fix,
RL> but it's kinda hard to build from there, since testing feedback has
RL> been basically zero. Pretty amazing considering how common Rhine
RL> hardware is. I guess I should write code for NUMA or ia64 instead,
RL> _they_ have testers <g>.

Well.. It didn't solve my problems.. Still the same errors.. :/

Everyone I know who have a rhineII-card does have the same problem.. I can
be your personal tester, just make my card work, pleeeeeease? :PP

RL> You shouldn't need to force full duplex, btw.

Nah, that was "just in case".. ;)

-- 
Henrik Persson
e-mail: nix@socialism.nu  WWW: http://nix.badanka.com
ICQ: 26019058             PGP/GPG: http://nix.badanka.com/pgp
PGP-Key-ID: 0x43B68116    PGP-Keyserver: pgp.mit.edu

--=.AGpp2J:AW?tC9m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+SSoK+uW4/EO2gRYRAjIBAJ0bVnzbkBwZJukY+3uf5wFMeRi/IACcC3kH
owcJwBYAPcP8KyzACDUQ1Io=
=ltWf
-----END PGP SIGNATURE-----

--=.AGpp2J:AW?tC9m--
