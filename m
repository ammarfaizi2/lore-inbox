Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288632AbSADOGC>; Fri, 4 Jan 2002 09:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288640AbSADOFw>; Fri, 4 Jan 2002 09:05:52 -0500
Received: from [217.200.21.164] ([217.200.21.164]:20387 "HELO
	markolaptop.markoer.net") by vger.kernel.org with SMTP
	id <S288632AbSADOFp>; Fri, 4 Jan 2002 09:05:45 -0500
Date: Fri, 4 Jan 2002 15:04:22 +0100
From: Marco Ermini <markoer@firenze.linux.it>
To: Tommi Kyntola <kynde@ts.ray.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: [patch] Re: Framebuffer...Why oh Why???
Message-Id: <20020104150422.3dc4117c.markoer@firenze.linux.it>
In-Reply-To: <Pine.LNX.4.33.0201041522030.1702-100000@behemoth.ts.ray.fi>
In-Reply-To: <20020103232614.26f2f5af.markoer@markoer.org>
	<Pine.LNX.4.33.0201041522030.1702-100000@behemoth.ts.ray.fi>
X-Mailer: Sylpheed version 0.6.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +"Lyz`Yqn/[+nPre_'A|Svg7k)orL^8-Ry6&@(Al;#ibq)H/"{g<eE,VkFB2lW_"!['Y0;c n~/~.$Y~(MLz'=#v;V9OuYhg9QH:`M5xNTS-V[7~`{M&wQKq#27w,_kNPxyF__Ppk\`h)-9
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.vs4j_MfU5TfFHg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.vs4j_MfU5TfFHg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jan 2002 15:27:03 +0200 (EET), Tommi Kyntola <kynde@ts.ray.fi>
wrote:

[...]
> > A similar things happened to me. I have a Toshiba Satellite 4080 XCDT, and
> > switching from XFree to console and back to XFree becomed impossibile with
> > the upgrade to Redhat 7.x and XFree 4. The problem is that the apm script
> > use to switch to console mode when I suspend (es. closing the laptop) and
> > when it resumes it tries to switch to XFree again, but this messes the
> > screen. I am still able to come back to console and killall X, but of
> > course I'll lose my current not saved works under X.
> > 
> > Under XFree 3 I could switch from X to console and back without problems -
> > anyway, after a couple of switches my laptop used to hang. I think X
> > writes to the uncorrect memory regions causing my laptop to hang.
> 
> This really is offtopic, because the above symptoms are caused solely by 
> XFree 4.1. The was discussion about this in XFree mailing lists.
> 
> A quick fix is to get a newer RedHat Rawhide XFree86 rpm (atleast
> 4.1.0-8 and later have that bug fixed) or better yet get a newer 
> tarball of X from xfree86.org 

Anyway, thanks. I'll try it when I'll have a fast connection next week (it's
more than 18 MB download).

> yers,
>  another member of "Linux on a Toshiba Satellite 4080xcdt (TM)" :)

You are missing "proud" ;-)


thanks

-- 
Marco Ermini
http://www.markoer.org
Never attribute to malice that which is adequately explained
by stupidity. (a sig from Slashdot postings)

--=.vs4j_MfU5TfFHg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8NbZqDT6FNtZ+AP4RAnqKAJ9P7Ogp0CoBC6PS6hiOaYYGHFF8lACfUtW2
nHPG4bsMhnergO3Q6IbUxWo=
=T5oL
-----END PGP SIGNATURE-----

--=.vs4j_MfU5TfFHg--

