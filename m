Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWCBV5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWCBV5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbWCBV5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:57:11 -0500
Received: from daemo09.udag.de ([62.146.33.133]:45005 "EHLO mail.udag.de")
	by vger.kernel.org with ESMTP id S1751637AbWCBV5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:57:10 -0500
From: Alexander Mieland <dma147@linux-stats.org>
Organization: Linux Statistics
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] LiSt - Linux Statistics - www.linux-stats.org
Date: Thu, 2 Mar 2006 22:57:01 +0100
User-Agent: KMail/1.9
References: <200602281812.42318.dma147@linux-stats.org> <20060301135916.GD23159@marowsky-bree.de> <6bffcb0e0603012328kc3e63bfn@mail.gmail.com>
In-Reply-To: <6bffcb0e0603012328kc3e63bfn@mail.gmail.com>
X-Face: "[.(DJ7n08,b3KjixLk+L+kK%5O{[xod@~Mo/'mqsUN#[CVc-:2Bkl1K9W)=?utf-8?q?JoO=7C=2EtD=26N6y=0A=09V=3B=26ah=27=3Fox=3AmGfop=3AC=5BO=60=2E8?=
 =?utf-8?q?3Qk-vk=5FX?=@=glws(}Ts]sVCi'9Mw~Wm4nIqVQ)
 =?utf-8?q?b=27qvcxbNX=5E=7B=0A=09kG=3F=3DK=2EOy?="cn{u.05=LxYh{l^kU?Y,lu5rG?@~M_3xmKjrPm:
X-Count: Registered Linux-User #249600
X-ePatents: NO!!!!
X-Motto: Give drugs no chance!
X-Kernel: 2.6.15-ck3--r1-fb-my4 SMP
X-Cpu: 2x Intel Pentium 2,6 GHz with HT
X-Distribution: Gentoo 2005.1-r1
X-Homepage: http://www.linux-stats.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4053739.QiCXis6Iui";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603022257.05535.dma147@linux-stats.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4053739.QiCXis6Iui
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Thursday 02 March 2006 08:28 schrieben Sie:
> Hi,
>
> On 01/03/06, Lars Marowsky-Bree <lmb@suse.de> wrote:
> > On 2006-02-28T18:12:37, Alexander Mieland <dma147@linux-stats.org>=20
wrote:
> > >  - The installation date of your distribution
> > >  - The hostname (no fqdn or ips)
> > >  - The architecture (x86/i586/i686, ppc, and so on)
> > >  - CPU information: vendor, model, number of cpus, frequencies
> > >  - RAM
> > >  - Swap
> > >  - Timezone
> > >  - user defined locales
> > >  - Windowmanager
> > >  - Kernel version
> > >  - Uptime information
> > >  - The size of mounted partitions (no shares)
> > >  - the used filesystems
> > >  - The hardware-IDs of used ISA/PCI/AGP and USB hardware
> >
> > This is very useful to focus development, eventually. It would be nice
> > if you could also come up with a way to provide feedback on the kernel
> > modules used (loaded will do, but used would be cuter ;-).
>
> Something like http://klive.cpushare.com/ ?
>

Yeah, that's great, but not really the same which I want to do.
My statistics about the kernel configuration and the loaded modules will be=
=20
much easier, especially easier to read. ;)

But that's not the only last thing which is planned.
I'm also planning an interface for users where they should be able to let=20
the interface/webpage generate the best matching .config for their kernel=20
based on the provided hard- and software. *g*
And it will provide an interactive helpsystem around the kernel-options and=
=20
much more.

Well more user (newbie) orientated, you see?

=2D-=20
Alexander 'dma147' Mieland                   2.6.15-ck3-r1-fb-my4 SMP
=46nuPG-ID: 27491179                      Registered Linux-User #249600
http://blog.linux-stats.org                http://www.linux-stats.org
http://www.mieland-programming.de          http://www.php-programs.de

--nextPart4053739.QiCXis6Iui
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEB2oxCYRNlSdJEXkRAkj4AKCBirMD1anuE3RU7D0SfIQxwt2L6gCfck/x
zCU7QoBvPU1uah5aZgIN+2M=
=whkj
-----END PGP SIGNATURE-----

--nextPart4053739.QiCXis6Iui--
