Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWB1RMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWB1RMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWB1RMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:12:45 -0500
Received: from daemo09.udag.de ([62.146.33.133]:38074 "EHLO mail.udag.de")
	by vger.kernel.org with ESMTP id S1751886AbWB1RMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:12:45 -0500
From: Alexander Mieland <dma147@linux-stats.org>
Organization: Linux Statistics
To: LKML <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] LiSt - Linux Statistics - www.linux-stats.org
Date: Tue, 28 Feb 2006 18:12:37 +0100
User-Agent: KMail/1.9
X-Face: "[.(DJ7n08,b3KjixLk+L+kK%5O{[xod@~Mo/'mqsUN#[CVc-:2Bkl1K9W)=?utf-8?q?JoO=7C=2EtD=26N6y=0A=09V=3B=26ah=27=3Fox=3AmGfop=3AC=5BO=60=2E8?=
 =?utf-8?q?3Qk-vk=5FX?=@=glws(}Ts]sVCi'9Mw~Wm4nIqVQ)
 =?utf-8?q?b=27qvcxbNX=5E=7B=0A=09kG=3F=3DK=2EOy?="cn{u.05=LxYh{l^kU?Y,lu5rG?@~M_3xmKjrPm:
X-Count: Registered Linux-User #249600
X-ePatents: NO!!!!
X-Motto: Give drugs no chance!
X-Kernel: 2.6.11-ck4-my2
X-Cpu: 2x Intel Pentium 2,6 GHz with HT
X-Distribution: Arch Linux 0.7 (Wombat)
X-Homepage: http://www.linux-stats.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart67136710.mD2uvA6pD4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602281812.42318.dma147@linux-stats.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart67136710.mD2uvA6pD4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello list,

I want to announce a project which was in discussion a bit beside klive.

Linux Statistics [1] or LiSt how this project is called, is afaik the one=20
and only page which generates such detailed statistics about *all* stuff=20
around linux.

It is a client/server project which generates accurate statistics of the=20
linux userbase and their hard- and software.
=46or this it provides a small client called "LiSt" which is written in=20
python and which everybody has to install to register his machine in our=20
database. This client application will then collect the following hard-=20
and software information from your linux system (use "LiSt -p" to see the=20
information which will be sent):

 - The installation date of your distribution
 - The hostname (no fqdn or ips)
 - The architecture (x86/i586/i686, ppc, and so on)
 - CPU information: vendor, model, number of cpus, frequencies
 - RAM
 - Swap
 - Timezone
 - user defined locales
 - Windowmanager
 - Kernel version
 - Uptime information
 - The size of mounted partitions (no shares)
 - the used filesystems
 - The hardware-IDs of used ISA/PCI/AGP and USB hardware

The client will send these information to our server, which stores them in=
=20
our database and generates accurate statistics out of them.

All of the collected information and data is absolutly anonymous!

Also read our privacy policy [2] to become sure that all is anonymous and=20
safe. Some more information on frequently asked questions can be found in=20
our FAQ [3].

Sincerely

Alex

[1] http://www.linux-stats.org
[2] http://www.linux-stats.org/?c=3Dprivacy
[3] http://www.linux-stats.org/?c=3Dfaq

=2D-=20
Alexander 'dma147' Mieland                   2.6.15-ck3-r1-fb-my4 SMP
=46nuPG-ID: 27491179                      Registered Linux-User #249600
http://blog.linux-stats.org                http://www.linux-stats.org
http://www.mieland-programming.de          http://www.php-programs.de

--nextPart67136710.mD2uvA6pD4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEBISKCYRNlSdJEXkRAmK/AJ49gefNDk6ofV1A4kpMp8ya172QHQCdEx/m
0D0iV1IWoL6QfYGdRY3w0FU=
=4W5+
-----END PGP SIGNATURE-----

--nextPart67136710.mD2uvA6pD4--
