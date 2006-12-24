Return-Path: <linux-kernel-owner+w=401wt.eu-S1754041AbWLXBMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbWLXBMG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 20:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbWLXBMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 20:12:06 -0500
Received: from relais.videotron.ca ([24.201.245.36]:50872 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbWLXBMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 20:12:05 -0500
Date: Sat, 23 Dec 2006 20:12:02 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add .mailmap for proper git-shortlog output
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0612232007170.18171@xanadu.home>
Content-id: <Pine.LNX.4.64.0612232007171.18171@xanadu.home>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_DK9hIiNvf0G/nVlwZgrlGw)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_DK9hIiNvf0G/nVlwZgrlGw)
Content-id: <Pine.LNX.4.64.0612232007172.18171@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=UTF-8
Content-transfer-encoding: 8BIT

This list was built into the git-shortlog tool and has been removed in 
the latest version. It should be maintained separately so this is what 
this patch does.

A couple more entries were added to the original list as well.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/.mailmap b/.mailmap
new file mode 100644
index 0000000..016b861
--- /dev/null
+++ b/.mailmap
@@ -0,0 +1,96 @@
+#
+# This list is used by git-shortlog to fix a few botched name translations
+# in the git archive, either because the author's full name was messed up
+# and/or not always written the same way, making contributions from the
+# same person appearing not to be so or badly displayed.
+#
+# repo-abbrev: /pub/scm/linux/kernel/git/
+#
+
+Aaron Durbin <adurbin@google.com>
+Adam Oldham <oldhamca@gmail.com>
+Adam Radford <aradford@gmail.com>
+Adrian Bunk <bunk@stusta.de>
+Alan Cox <alan@lxorguk.ukuu.org.uk>
+Alan Cox <root@hraefn.swansea.linux.org.uk>
+Aleksey Gorelov <aleksey_gorelov@phoenix.com>
+Al Viro <viro@ftp.linux.org.uk>
+Al Viro <viro@zenIV.linux.org.uk>
+Andreas Herrmann <aherrman@de.ibm.com>
+Andrew Morton <akpm@osdl.org>
+Andrew Vasquez <andrew.vasquez@qlogic.com>
+Andy Adamson <andros@citi.umich.edu>
+Arnaud Patard <arnaud.patard@rtp-net.org>
+Arnd Bergmann <arnd@arndb.de>
+Axel Dyks <xl@xlsigned.net>
+Ben Gardner <bgardner@wabtec.com>
+Ben M Cahill <ben.m.cahill@intel.com>
+Björn Steinbrink <B.Steinbrink@gmx.de>
+Brian Avery <b.avery@hp.com>
+Brian King <brking@us.ibm.com>
+Christoph Hellwig <hch@lst.de>
+Corey Minyard <minyard@acm.org>
+David Brownell <david-b@pacbell.net>
+David Woodhouse <dwmw2@shinybook.infradead.org>
+Domen Puncer <domen@coderock.org>
+Douglas Gilbert <dougg@torque.net>
+Ed L. Cashin <ecashin@coraid.com>
+Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+Felipe W Damasio <felipewd@terra.com.br>
+Felix Kuhling <fxkuehl@gmx.de>
+Felix Moeller <felix@derklecks.de>
+Filipe Lautert <filipe@icewall.org>
+Franck Bui-Huu <vagabon.xyz@gmail.com>
+Frank Zago <fzago@systemfabricworks.com>
+Greg Kroah-Hartman <greg@echidna.(none)>
+Greg Kroah-Hartman <gregkh@suse.de>
+Greg Kroah-Hartman <greg@kroah.com>
+Henk Vergonet <Henk.Vergonet@gmail.com>
+Henrik Kretzschmar <henne@nachtwindheim.de>
+Herbert Xu <herbert@gondor.apana.org.au>
+Jacob Shin <Jacob.Shin@amd.com>
+James Bottomley <jejb@mulgrave.(none)>
+James Bottomley <jejb@titanic.il.steeleye.com>
+James E Wilson <wilson@specifix.com>
+James Ketrenos <jketreno@io.(none)>
+Jean Tourrilhes <jt@hpl.hp.com>
+Jeff Garzik <jgarzik@pretzel.yyz.us>
+Jens Axboe <axboe@suse.de>
+Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
+John Stultz <johnstul@us.ibm.com>
+Juha Yrjola <at solidboot.com>
+Juha Yrjola <juha.yrjola@nokia.com>
+Juha Yrjola <juha.yrjola@solidboot.com>
+Kay Sievers <kay.sievers@vrfy.org>
+Kenneth W Chen <kenneth.w.chen@intel.com>
+Koushik <raghavendra.koushik@neterion.com>
+Leonid I Ananiev <leonid.i.ananiev@intel.com>
+Linas Vepstas <linas@austin.ibm.com>
+Matthieu CASTET <castet.matthieu@free.fr>
+Michel Dänzer <michel@tungstengraphics.com>
+Mitesh shah <mshah@teja.com>
+Morten Welinder <terra@gnome.org>
+Morten Welinder <welinder@anemone.rentec.com>
+Morten Welinder <welinder@darter.rentec.com>
+Morten Welinder <welinder@troll.com>
+Nguyen Anh Quynh <aquynh@gmail.com>
+Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
+Patrick Mochel <mochel@digitalimplant.org>
+Peter A Jonsson <pj@ludd.ltu.se>
+Praveen BP <praveenbp@ti.com>
+Rajesh Shah <rajesh.shah@intel.com>
+Ralf Baechle <ralf@linux-mips.org>
+Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
+Rémi Denis-Courmont <rdenis@simphalempin.com>
+Rudolf Marek <R.Marek@sh.cvut.cz>
+Rui Saraiva <rmps@joel.ist.utl.pt>
+Sachin P Sant <ssant@in.ibm.com>
+Sam Ravnborg <sam@mars.ravnborg.org>
+Simon Kelley <simon@thekelleys.org.uk>
+Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
+Stephen Hemminger <shemminger@osdl.org>
+Tejun Heo <htejun@gmail.com>
+Thomas Graf <tgraf@suug.ch>
+Tony Luck <tony.luck@intel.com>
+Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
+Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

--Boundary_(ID_DK9hIiNvf0G/nVlwZgrlGw)--
