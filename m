Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSDIKSs>; Tue, 9 Apr 2002 06:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313835AbSDIKSr>; Tue, 9 Apr 2002 06:18:47 -0400
Received: from kirk.etnet.fr ([195.146.194.12]:14093 "EHLO kirk.etnet.fr")
	by vger.kernel.org with ESMTP id <S313125AbSDIKSq>;
	Tue, 9 Apr 2002 06:18:46 -0400
Date: Tue, 9 Apr 2002 12:18:21 +0200
From: Guillaume Gimenez <ggimenez@prologue-software.fr>
To: Nick Martens <nickm@kabelfoon.nl>
Cc: linux-kernel@vger.kernel.org,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.4.18 Boot problem
Message-Id: <20020409121821.18817b76.ggimenez@prologue-software.fr>
In-Reply-To: <200204090939.g399dlX02029@Port.imtp.ilyichevsk.odessa.ua>
Organization: Prologue Software
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #aYAM@CUO[tWCSX=wrnq$Aou=9$*@-<8{sgt[sSL;U(&AIRAJpcVt`0`=<gW@j?B5~[$uVf j6<bh?MB`;Ug#@.HxckUG)/`~dT(,3~\&q{QQX<*yu,p,XGfU+-~OO^w@?FC;Yv+uUq']Y&?P)?G:n cP^h4o=/N)gGrj}o\dB8}&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.r1ig/80cWWPt4R"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.r1ig/80cWWPt4R
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Denis Vlasenko a écrit:
    Denis> On 8 April 2002 18:32, Nick Martens wrote:
    Denis> > I don't expect it to be a memory problem my system is really stable and
    Denis> > the weirdest about the problem is that it only happens the first time I
    Denis> > boot up after my pc has been turned off for a while and there are no
    Denis> > problems when i boot 2.5.1 it only crashes on shutdowns on that kernel.
    Denis> > I have tried updating all kind of things, but noting seems to work
    Denis> 
    Denis> Is your "for a while" >= ten seconds? Nothing in CPU/RAM can survive
    Denis> that long.
    Denis> 
    Denis> I'd say this is a hardware problem then. Something in your box does not like 
    Denis> to be cold.
    Denis> --
    Denis> vda

Is Nick's system based on a Tyan TigerMP mobo with 2 cpu ?
I have the same kind of problem.

My TigerMP based system is very unstable the first 5 minutes
I use it, and then become as stable as I can expect.

I suspect my power suply to be picky about temperature and cannot
deliver the needed power when it is cold. It is an enermax 350W


Regards, 

Guillaume Gimenez

--=.r1ig/80cWWPt4R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6b (GNU/Linux)

iD8DBQE8sr/x00PDGGWQcLIRAu0WAJ97KoNbMqS14iIZFqW34JGVAzVjywCgsdId
nT+v1C3yW9j0pzInudt0aJc=
=Y0IK
-----END PGP SIGNATURE-----

--=.r1ig/80cWWPt4R--

