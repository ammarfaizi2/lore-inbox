Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSILS2m>; Thu, 12 Sep 2002 14:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316996AbSILS2m>; Thu, 12 Sep 2002 14:28:42 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:42512 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316898AbSILS2e>; Thu, 12 Sep 2002 14:28:34 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.56819.247501.512522@laputa.namesys.com>
Date: Thu, 12 Sep 2002 22:33:23 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: Hans Reiser <reiser@namesys.com>, Nick LeRoy <nleroy@cs.wisc.edu>,
       jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: XFS?
In-Reply-To: <3D80DC19.4080508@jpl.nasa.gov>
References: <p73wupuq34l.fsf@oldwotan.suse.de>
	<200209101518.31538.nleroy@cs.wisc.edu>
	<20020911084327.GF6085@pegasys.ws>
	<200209110820.36925.nleroy@cs.wisc.edu>
	<3D7F789F.2030103@namesys.com>
	<3D80DC19.4080508@jpl.nasa.gov>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Emacs-Acronym: Edwardian Manifestation of All Colonial Sins
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Whitehead writes:
 > Hans Reiser wrote:
 > > Nick LeRoy wrote:
 > > 
 > >>  
 > >>
 > >>
 > >> Think about this:  Namesys is working on Reiserfs v4.0.  v4.0.  Hell - 
 > >> it's only been incorporated into the mainstream kernel for less than a 
 > >> year (at least by my recollection), yet it keeps advancing.  I have 
 > >> _no_ idea what UFS version Solaris 8 is using (admittedly at least 
 > >> somewhat due to ignorance -- I use Solaris because I have a good ol' 
 > >> SPARCprinter which alas is not supported by Linux), or whether they've 
 > >> bother to do development on it to make it better, faster, etc.  Yet, 
 > >> _we_ get this advancement all the time.  Isn't it great?!
 > >>
 > >>  
 > >>
 > > I think you'll really like v4, it is a complete rewrite from scratch, 
 > > and far better in every way.  :)
 > > 
 > > Hans
 > 
 > What blows my mind (from someone that only watches kernel development) 
 > is how one project, XFS, a filesystem basically "done" is excluded from 
 > the mainline kernel while ReiserFS is getting a "complete rewrite from 
 > scratch".
 > 
 > Maybe I don't get it cause I'm just watching... ;)

Then you missed "reiserfs inclusion into the kernel" soap opera.

And besides, reiserfs in mainline to no extent means reiser4 in mainline
(unfortunately).

 > 
 > -- 
 > Bryan Whitehead

Nikita.

 > SysAdmin - JPL - Interferometry Systems and Technology
 > Phone: 818 354 2903
 > driver@jpl.nasa.gov
 > 
