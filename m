Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312297AbSCTXxv>; Wed, 20 Mar 2002 18:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312304AbSCTXxf>; Wed, 20 Mar 2002 18:53:35 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:42391 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312297AbSCTXuv>; Wed, 20 Mar 2002 18:50:51 -0500
Date: Wed, 20 Mar 2002 18:52:03 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  March 20, 2002
Message-ID: <20020320235203.GS29518@ufies.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C9874E0.14526.3D4235FF@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guillaume, could you add an entry for UDF on CDRW write support that
Jens Axboe intents to merge in 2.5 (see url).

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101583526325962&w=3D2

Thanks,
Christophe

On Wed, Mar 20, 2002 at 11:39:12AM -0500, Guillaume Boissiere wrote:
> The latest status update for the 2.5 series is available at
> http://kernelnewbies.org/status/ with links for each item.
>=20
> Of note since last week is the merge of NAPI, which is a way=20
> to deal with high network packet load -- networking drivers
> authors may want to take a look at the porting guide.
> Also merged is a big ACPI patch, which should pave the way=20
> for better power management in Linux.
>=20
> As usual, please let me know of anything incorrect or missing. =20
> Cheers,
>=20
> -- Guillaume
>=20
> ------------------------------------------
> Kernel 2.5 status  -  March 20th, 2002
> (Latest kernel release is 2.5.7)
>=20
>=20
> Features:
>=20
> Merged
> o in 2.5.1+   Rewrite of the block IO (bio) layer             (Jens Axboe)
> o in 2.5.2    Initial support for USB 2.0                     (David=20
> Brownell, Greg Kroah-Hartman, etc.)
> o in 2.5.2    Per-process namespaces, late-boot cleanups      (Al Viro,=
=20
> Manfred Spraul)
> o in 2.5.2+   New scheduler for improved scalability          (Ingo Molna=
r)
> o in 2.5.2+   New kernel device structure (kdev_t)            (Linus=20
> Torvalds, etc.)
> o in 2.5.3    IDE layer update                                (Andre=20
> Hedrick)
> o in 2.5.3    Support reiserfs external journal               (Reiserfs=
=20
> team)
> o in 2.5.3    Generic ACL (Access Control List) support       (Nathan Sco=
tt)
> o in 2.5.3    PnP BIOS driver                                 (Alan Cox,=
=20
> Thomas Hood, Dave Jones, etc.)
> o in 2.5.3+   New driver model & unified device tree          (Patrick=20
> Mochel)
> o in 2.5.4    Add preempt kernel option                       (Robert Lov=
e,=20
> MontaVista team)
> o in 2.5.4    Support for Next Generation POSIX Threading     (NGPT team)
> o in 2.5.4+   Porting all input devices over to input API     (Vojtech=20
> Pavlik, James Simmons)
> o in 2.5.5    Add ALSA (Advanced Linux Sound Architecture)    (ALSA team)
> o in 2.5.5    Pagetables in highmem support                   (Ingo Molna=
r,=20
> Arjan van de Ven)
> o in 2.5.5    New architecture: AMD 64-bit (x86-64)           (Andi Kleen=
,=20
> x86-64 Linux team)
> o in 2.5.5    New architecture: PowerPC 64-bit (ppc64)        (Anton=20
> Blanchard, ppc64 team)
> o in 2.5.6    Add JFS (Journaling FileSystem from IBM)        (JFS team)
> o in 2.5.6    per_cpu infrastructure                          (Rusty=20
> Russell)
> o in 2.5.6    HDLC (High-level Data Link Control) update      (Krzysztof=
=20
> Halasa)
> o in 2.5.6    smbfs Unicode and large file support            (Urban=20
> Widmark)=20
> o in 2.5.7    New driver API for Wireless Extensions          (Jean=20
> Tourrilhes)
> o in 2.5.7    Video for Linux (V4L) redesign                  (Gerd Knorr)
> o in 2.5.7    Futexes (Fast Lightweight Userspace Semaphores) (Rusty=20
> Russell, etc.)
> o in 2.5.7+   NAPI network interrupt mitigation               (Jamal Hadi=
=20
> Salim, Robert Olsson, Alexey Kuznetsov)
> * in 2.5.7+   ACPI (Advanced Configuration & Power Interface) (Andy Grove=
r,=20
> ACPI team)
>=20
> o Pending     Finalize new device naming convention           (Linus=20
> Torvalds)
> o in -dj      Rewrite of the framebuffer layer                (James=20
> Simmons)
> * in -ac      Strict address space accounting                 (Alan Cox)
> * in -ac      PCMCIA Zoom video support                       (Alan Cox)
>=20
> o Ready       Add hardware sensors drivers                    (lm_sensors=
=20
> team)
> o Ready       New kernel config system: CML2                  (Eric Raymo=
nd)
> o Ready       Read-Copy Update Mutual Exclusion               (Dipankar=
=20
> Sarma, Rusty Russell, Andrea Arcangeli, LSE Team)
> o Ready       Better event logging for enterprise systems     (Larry=20
> Kessler, evlog team)
> o Ready       New quota system supporting plugins             (Jan Kara)
>=20
> o Beta        New kernel build system (kbuild 2.5)            (Keith Owen=
s)
> o Beta        Add support for CPU clock/voltage scaling       (Erik Mouw,=
=20
> Dave Jones, Russell King, Arjan van de Ven)
> o Beta        Serial driver restructure                       (Russell Ki=
ng)
> o Beta        New IO scheduler                                (Jens Axboe)
> o Beta        Add XFS (A journaling filesystem from SGI)      (XFS team)
> o Beta        New VM with reverse mappings                    (Rik van Ri=
el)
> o Beta        Fix long-held locks for low scheduling latency  (Andrew=20
> Morton, Robert Love, etc.)
> o Beta        Build option for Linux Trace Toolkit (LTT)      (Karim=20
> Yaghmour)
> o Beta        Add Linux Security Module (LSM)                 (LSM team)
> o Beta        Hotplug CPU support                             (Rusty=20
> Russell)
> o Beta        Per-mountpoint read-only, union-mounts, unionfs (Al Viro)
> o Beta        EVMS (Enterprise Volume Management System)      (EVMS team)
> o Beta        LVM (Logical Volume Manager) v2.0               (LVM team)
> o Beta        Linux booting ELF images                        (Eric=20
> Biederman)
> o Beta        First pass at LinuxBIOS support                 (Eric=20
> Biederman)
> o Beta        Dynamic Probes                                  (Suparna=20
> Bhattacharya, dprobes team)
> o Beta        Scalable CPU bitmasks                           (Russ Weigh=
t)
> o Beta        Page table sharing                              (Daniel=20
> Phillips)
> o Beta        Rewrite of the console layer                    (James=20
> Simmons)
> o Beta        ext2/ext3 online resize support                 (Andreas=20
> Dilger)
> o Beta        Radix-tree pagecache                            (Momchil=20
> Velikov, Christoph Hellwig)
> o Beta        Replace old NTFS driver with NTFS TNG driver    (Anton=20
> Altaparmakov)
> o Beta        Fast walk dcache                                (Hanna Lind=
er)
> o Beta        Add User-Mode Linux (UML)                       (Jeff Dike)
>=20
> o Alpha       Better support of high-end NUMA machines        (NUMA team)
> o Alpha       Add Asynchronous IO (aio) support               (Ben LaHais=
e)
> o Alpha       Overhaul PCMCIA support                         (David=20
> Woodhouse, David Hinds)
> o Alpha       More complete IEEE 802.2 stack                  (Arnaldo, J=
ay=20
> Schullist, from Procom donated code)
> o Alpha       Full compliance with IPv6                       (Alexey=20
> Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI team)
> o Alpha       UMSDOS (Unix under MS-DOS) Rewrite              (Al Viro)
> o Alpha       Scalable Statistics Counter                     (Ravikiran=
=20
> Thirumalai)
> o Alpha       Linux Kernel Crash Dumps                        (Matt=20
> Robinson, LKCD team)
> o Alpha       Add support for NFS v4                          (NFS v4 tea=
m)
> o Alpha       ext2/ext3 large directory support: HTree index  (Daniel=20
> Phillips, Christopher Li, Ted Ts'o)
> o Alpha       Delayed disk block allocation                   (Andrew=20
> Morton)
> * Alpha       Improved i2o (Intelligent Input/Ouput) layer    (Alan Cox)
>=20
> o Started     More complete NetBEUI stack                     (Arnaldo=20
> Carvalho de Melo, from Procom donated code)
> o Started     Remove use of the BKL (Big Kernel Lock)         (Alan Cox,=
=20
> Robert Love, Neil Brown, etc.)
> o Started     Change all drivers to new driver model          (All=20
> maintainers)
> o Started     Reiserfs v4                                     (Reiserfs=
=20
> team)
> o Started     Move ISDN4Linux to CAPI based interface         (ISDN4Linux=
=20
> team)
>=20
> o Draft #2    New lightweight library (klibc)                 (Greg Kroah-
> Hartman)
> o Draft #3    Replace initrd by initramfs                     (H. Peter=
=20
> Anvin, Al Viro)
> o Planning    Add thrashing control                           (Rik van Ri=
el)
> o Planning    Remove all hardwired drivers from kernel        (Alan Cox,=
=20
> etc.)
> o Planning    Generic parameter/command line interface        (Keith Owen=
s)
> o Planning    New mount API                                   (Al Viro)
> o Planning    New MTRR (Memory Type Range Register) driver    (Dave Jones)
>=20
>=20
> Cleanups:
>=20
> Merged
> o in 2.5.3    Break Configure.help into multiple files        (Linus=20
> Torvalds)
> o in 2.5.3    Untangle include file dependancies              (Dave Jones=
,=20
> Roman Zippel)
> o in 2.5.4    Per network protocol slabcache & sock.h         (Arnaldo=20
> Carvalho de Melo)
> o in 2.5.4    Per filesystem slabcache & fs.h                 (Daniel=20
> Phillips, Jeff Garzik, Al Viro)
> o in 2.5.6    Killing kdev_t for block devices                (Al Viro)
>=20
> o Ready       Switch to ->get_super() for file_system_type    (Al Viro)
> o Ready       ->getattr() ->setattr() ->permission() changes  (Al Viro)
> o Ready       Remove dcache_lock                              (Maneesh=20
> Soni, IBM team)
>=20
> o Beta        file.h and INIT_TASK                            (Benjamin=
=20
> LaHaise)
> o Beta        Proper UFS fixes, ext2 and locking cleanups     (Al Viro)
> o Beta        Lifting limitations on mount(2)                 (Al Viro)
>=20
> o Started     Split up x86 setup.c into managable pieces      (Dave Jones=
,=20
> Randy Dunlap)
> o Started     Reorder x86 initialization                      (Dave Jones=
,=20
> Randy Dunlap)
>=20
> Have some free time and want to help?  Check out the Kernel Janitor=20
> TO DO list for a list of source code cleanups you can work on. =20
> A great place to start learning more about kernel internals!
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

There is no snooze button on a cat who wants breakfast.

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8mSCjj0UvHtcstB4RArOoAJwL53Wlm+GmTzmMiWXfEFoxvD/BvwCfWsUx
EOvLByLL0Tp1+kLonTj0ZPs=
=29NY
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--
