Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289169AbSAGLMA>; Mon, 7 Jan 2002 06:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289175AbSAGLLu>; Mon, 7 Jan 2002 06:11:50 -0500
Received: from [213.140.14.139] ([213.140.14.139]:39296 "HELO
	markolaptop.markoer.net") by vger.kernel.org with SMTP
	id <S289169AbSAGLLg>; Mon, 7 Jan 2002 06:11:36 -0500
Date: Mon, 7 Jan 2002 12:11:26 +0100
From: Marco Ermini <markoer@firenze.linux.it>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: werner.lx@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-Id: <20020107121126.1e4d5594.markoer@firenze.linux.it>
In-Reply-To: <Pine.LNX.4.33.0201070835400.18265-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0201070835400.18265-100000@netfinity.realnet.co.sz>
X-Mailer: Sylpheed version 0.6.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +"Lyz`Yqn/[+nPre_'A|Svg7k)orL^8-Ry6&@(Al;#ibq)H/"{g<eE,VkFB2lW_"!['Y0;c n~/~.$Y~(MLz'=#v;V9OuYhg9QH:`M5xNTS-V[7~`{M&wQKq#27w,_kNPxyF__Ppk\`h)-9
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.rg+eTBboaE3DKQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.rg+eTBboaE3DKQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jan 2002 08:36:59 +0200 (SAST), Zwane Mwaikambo
<zwane@linux.realnet.co.sz> wrote:

> Do you have CONFIG_MTRR enabled?
> 
> Regards,
> 	Zwane Mwaikambo

Yes. Upgrading to the new XFree from RedHat's rawhide (and "degrading" from
kernel 2.5.0 to 2.4.18-pre1) solved the problem.

bye

-- 
Marco Ermini
http://www.markoer.org
Perche' perdere tempo ad imparare quando l'ignoranza e' istantanea? (Hobbes)

--=.rg+eTBboaE3DKQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8OYJgtGvmygIFswwRAvktAJwMCTYgtfQrhsSzk/hhq+1RcmtFBwCfSO6T
716ugjtfctTByCKu7vFaZhc=
=Akic
-----END PGP SIGNATURE-----

--=.rg+eTBboaE3DKQ--

