Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVAEL7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVAEL7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVAEL7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:59:10 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52943 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262347AbVAEL6s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:58:48 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed,_05_Jan_2005_11_58_44_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050105115844.4B13B790DD@merlin.emma.line.org>
Date: Wed,  5 Jan 2005 12:58:44 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.258, 2005-01-05 12:56:32+01:00, samel@mail.cz
  shortlog:
    shortlog: added 31 new addresses

ChangeSet@1.257, 2005-01-05 12:55:08+01:00, matthias.andree@gmx.de
  shortlog:
    add five new addresses

[I recreated the tree from the upstream 1.254 - sorry for the confusion!]

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

##### GNUPATCH #####
--- 1.226/shortlog	2004-12-23 09:09:10 +01:00
+++ 1.228/shortlog	2005-01-05 12:56:02 +01:00
@@ -240,6 +240,7 @@
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
 'albert:users.sf.net' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
+'albertcc:tw.ibm.com' => 'Albert Lee',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
@@ -377,6 +378,7 @@
 'baldrick:free.fr' => 'Duncan Sands',
 'baldrick:wanadoo.fr' => 'Duncan Sands',
 'ballabio_dario:emc.com' => 'Dario Ballabio',
+'baris:idealteknoloji.com' => 'M. Baris Demiray',
 'barrow_dj:yahoo.com' => 'D. J. Barrow',
 'barryn:pobox.com' => 'Barry K. Nathan', # lbdb
 'bart.de.schuyer:pandora.be' => 'Bart De Schuymer',
@@ -396,6 +398,7 @@
 'bdschuym:pandora.be' => 'Bart De Schuymer',
 'bdshuym:pandora.be' => 'Bart De Schuymer', # it's typo IMHO
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
+'becky.gill:freescale.com' => 'Becky Gill',
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'ben-linux:fluff.org' => 'Ben Dooks',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
@@ -441,6 +444,7 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bo.henriksen:com.rmk.(none)' => 'Bo Henriksen',
 'bo.henriksen:nordicid.com' => 'Bo Henriksen',
+'bodo.stroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'bogdan.costescu:iwr.uni-heidelberg.de' => 'Bogdan Costescu',
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'boris.hu:intel.com' => 'Boris Hu',
@@ -463,6 +467,7 @@
 'brking:us.ibm.com' => 'Brian King',
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
+'brugolsky:telemetry-investments.com' => 'Bill Rugolsky',
 'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
 'bstroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
@@ -497,6 +502,7 @@
 'castet.matthieu:free.fr' => 'Matthieu Castet',
 'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
+'catab at umbrella.ro' => 'Catalin Boie',
 'catab:deuroconsult.ro' => 'Catalin Boie',
 'catab:umbrella.ro' => 'Catalin Boie',
 'catalin.marinas:com.rmk.(none)' => 'Catalin Marinas',
@@ -586,6 +592,7 @@
 'craig:gumstix.com' => 'Craig Hughes',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
+'crn:netunix.com' => 'Chris Newport',
 'cruault:724.com' => 'Charles-Edouard Ruault',
 'cspalletta:yahoo.com' => 'Carl Spalletta',
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
@@ -887,6 +894,7 @@
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fujiwara:linux-m32r.org' => 'Hayato Fujiwara',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
+'fxhuehl:gmx.de' => 'Felix Kuehling',
 'fzago:austin.rr.com' => 'Frank Zago', # google
 'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
 'gaa:ulticom.com' => 'Gary Algier', # google
@@ -1111,6 +1119,7 @@
 'janitor:at.none.(rmk)' => 'Maximilian Attems',
 'janitor:at.rmk.(none)' => 'Maximilian Attems',
 'janitor:sternwelten.at' => 'Maximilian Attems',
+'jason.d.gaston:intel.com' => 'Jason Gaston',
 'jason.davis:unisys.com' => 'Jason Davis',
 'jasonuhl:sgi.com' => 'Jason Uhlenkott',
 'jasper:vs19.net' => 'Jasper Spaans',
@@ -1136,6 +1145,7 @@
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
 'jdittmer:ppp0.net' => 'Jan Dittmer',
+'jdmason:us.ibm.com' => 'Jon Mason',
 'jdow:earthlink.net' => 'Joanne Dow',
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
@@ -1297,6 +1307,7 @@
 'junx.yao:intel.com' => 'Yao Jun',
 'jurgen:botz.org' => 'Jürgen Botz',
 'jurij:woodyd.org' => 'Jurij Smakov',
+'jurij:wooyd.org' => 'Jurij Smakov',
 'jwboyer:charter.net' => 'Josh Boyer',
 'jwboyer:infradead.org' => 'Josh Boyer',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
@@ -1345,6 +1356,7 @@
 'kdrader:us.ibm.com' => 'Kurtis D. Rader',
 'keith:tungstengraphics.com' => 'Keith Whitwell',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
+'keithw:tungstengraphics.com' => 'Keith Withwell',
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel-hacker:bennee.com' => 'Alex Bennee',
@@ -1412,6 +1424,7 @@
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kronos:people.it' => 'Luca Tettamanti',
+'ksakamot:linux-m32r.org' => 'Kei Sakamoto',
 'kszysiu:iceberg.elsat.net.pl' => 'Krzysztof Rusocki',
 'kuba:mareimbrium.org' => 'Kuba Ober',
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
@@ -1447,11 +1460,13 @@
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
+'len.brown2intel.com' => 'Len Brown',
 'len.brown:intel.com' => 'Len Brown',
 'lenb:dhcppc11.' => 'Len Brown',
 'lenb:dhcppc3.' => 'Len Brown',
 'lenb:dhcppc6.' => 'Len Brown',
 'lenehan:twibble.org' => 'Jamie Lenehan',
+'lenz:cs.wisc.edu' => 'John Lenz',
 'leoli:freescale.com' => 'Li Yang',
 'lesanti:sinectis.com.ar' => 'Leandro Santi',
 'lethal:linux-sh.org' => 'Paul Mundt',
@@ -1654,6 +1669,7 @@
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'mhtran:us.ibm.com' => 'Mike Tran',
 'mhuth:mvista.com' => 'Mark Huth',
+'mhw:wittsend.com' => 'Michael H. Warfield',
 'michael.kerrisk:gmx.net' => 'Michael Kerrisk',
 'michael.krauth:web.de' => 'Michael Krauth',
 'michael.ni:hp.com' => 'Michael Ni',
@@ -1696,6 +1712,8 @@
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
 'minyard:acm.org' => 'Corey Minyard',
+'minyard:mvista.com' => 'Corey Minyard',
+'miquels:cistron.net' => 'Miquel van Smoorenburg',
 'miquels:cistron.nl' => 'Miquel van Smoorenburg',
 'mirage:kaotik.org' => 'Tiago Sousa',
 'mita:yacht.ocn.ne.jp' => 'Akinobu Mita',
@@ -1757,6 +1775,7 @@
 'mw:microdata-pos.de' => 'Michael Westermann',
 'my:post.utfors.se' => 'Mikael Ylikoski',
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
+'mzzhgg:de.rmk.(none)' => 'Lennart Poettering',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nacc:us.ibm.com' => 'Nishanth Aravamudan',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
@@ -1796,6 +1815,7 @@
 'nikkne:hotpop.com' => 'Nikola Knezevic',
 'niraj17:iitbombay.org' => 'Niraj Kumar',
 'nitin.a.kamble:intel.com' => 'Nitin A. Kamble',
+'nitin.hande:sun.com' => 'Nitin Hande',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
 'nkbj:image.dk' => 'Niels Kristian Bech Jensen',
@@ -1975,10 +1995,12 @@
 'pluto:pld-linux.org' => 'Pawel Sikora',
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmarques:grupopie.com' => 'Paulo Marques',
+'pmaydell:chiark.greenend.org.uk' => 'Peter Maydell',
 'pmclean:linuxfreak.ca' => 'Patrick McLean',
 'pmeda:akamai.com' => 'Prasanna Meda',
 'pmenage:ensim.com' => 'Paul Menage',
 'pnelson:andrew.cmu.edu' => 'Peter Nelson',
+'pnelson:suse.cz' => 'Peter Nelson',
 'pontus.fuchs:tactel.se' => 'Pontus Fuchs',
 'porter:cox.net' => 'Matt Porter',
 'poup:poupinou.org' => 'Bruno Ducrot',
@@ -2014,6 +2036,7 @@
 'r.marek:sh.cvut.cz' => 'Rudolf Marek',
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
 'radford:indigita.com' => 'Jim Radford',
+'raghavendra.koushik:s2io.com' => 'Raghavendra Koushik',
 'rainer.weikusat:sncag.com' => 'Rainer Weikusat',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
@@ -2029,6 +2052,7 @@
 'rathamahata:php4.ru' => 'Sergey S. Kostyliov',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'raven:themaw.net' => 'Ian Kent',
+'ravinandan.arakali:s2io.com' => 'Ravinandan Arakali',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
 'rbradetich:uswest.net' => 'Ryan Bradetich',
@@ -2063,6 +2087,7 @@
 'riel:imladris.surriel.com' => 'Rik van Riel',
 'riel:redhat.com' => 'Rik van Riel',
 'riel:surriel.com' => 'Rik van Riel',
+'rjmx:rjmx.net' => 'Ron Murray',
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rkagan:mail.ru' => 'Roman Kagan',
 'rl:hellgate.ch' => 'Roger Luethi',
@@ -2154,6 +2179,7 @@
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
 'saidi:umich.edu' => 'Ali Saidi',
 'sailer:scs.ch' => 'Thomas Sailer',
+'sakugawa:linux-m32r.org' => 'Mamoru Sakugawa',
 'sam:mars.ravnborg.org' => 'Sam Ravnborg',
 'sam:ravnborg.org' => 'Sam Ravnborg',
 'samel:mail.cz' => 'Vitezslav Samel',
@@ -2239,6 +2265,7 @@
 'siegfried.hildebrand:fernuni-hagen.de' => 'Siegfried Hildebrand',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simcha:chatka.org' => 'Jan Topinski',
+'simlo:phys.au.dk' => 'Esben Nielsen',
 'simon.derr:bull.net' => 'Simon Derr',
 'simon:instant802.com' => 'Simon Barber',
 'simon:thekelleys.org.uk' => 'Simon Kelley',
@@ -2252,12 +2279,14 @@
 'sl:lineo.com' => 'Stuart Lynne',
 'slansky:usa.net' => 'Petr Slansky',
 'sleddog:us.ibm.com' => 'Dave Boutcher',
+'slpratt:austin.ibm.com' => 'Steven Pratt',
 'sluskyb:paranoiacs.org' => 'Ben Slusky',
 'sm0407:nurfuerspam.de' => 'Stefan Meyknecht',
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
+'sndirsch:suse.de' => 'Stefan Dirsch',
 'sneakums:zork.net' => 'Sean Neakums',
 'soete.joel:tiscali.be' => 'Joel Soete',
 'sojka:planetarium.cz' => 'Michal Sojka',
@@ -2326,6 +2355,7 @@
 'stewart:linux.org.au' => 'Stewart Smith',
 'stewart:wetlogic.net' => 'Paul Stewart',
 'stewartsmith:mac.com' => 'Stewart Smith',
+'stkn:gentoo.org' => 'Stefan Knoblich',
 'stoffel:lucent.com' => 'John Stoffel',
 'strosake:us.ibm.com' => 'Michael Strosaker',
 'stsp:aknet.ru' => 'Stas Sergeev',
@@ -2334,6 +2364,7 @@
 'stuber:loria.fr' => 'Jürgen Stuber',
 'suckfish:ihug.co.nz' => 'Ralph Loader',
 'sud:latinsud.com' => 'Alex Grijander',
+'sugai:isl.melco.co.jp' => 'Naoto Sugai',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
 'sundarapandian.duraijai:intel.com' => 'Sundarapandian Durairaj',
@@ -2456,7 +2487,9 @@
 'tritol:trilogic.cz' => 'Lubomír Bláha',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
+'trond.myklebust:netapp.com' => 'Trond Myklebust',
 'trondmy:trondhjem.org' => 'Trond Myklebust',
+'tsbogend:alpha.franken.de' => 'Thomas Bogendoerfer',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
 'tspat:de.ibm.com' => 'Thomas Spatzier',
 'ttodorov:web.de' => 'Todor Todorov',
@@ -2501,6 +2534,7 @@
 'vesely:gjh.sk' => 'Jozef Vesely',
 'vesselin:alphawave.com.au' => 'Vesselin Kostadiov',
 'vfort:provident-solutions.com' => 'Vernon A. Fort',
+'vgoyal:in.ibm.com' => 'Vivek Goyal',
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
@@ -2523,6 +2557,7 @@
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
 'vrajesh:eecs.umich.edu' => 'Rajesh Venkatasubramanian',
 'vrajesh:umich.edu' => 'Rajesh Venkatasubramanian',
+'vs:namesys.com' => 'Vladimir Saveliev',
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'vsu:altlinux.ru' => 'Sergey Vlasov',
 'wa:almesberger.net' => 'Werner Almesberger',
@@ -2611,6 +2646,7 @@
 'zecke:flint.arm.linux.org.uk' => 'Holger Freyther',
 'zecke:org.rmk.(none)' => 'Holger Freyther',
 'zeevon:debian.org' => 'Warren A. Layton',
+'zhenyu.z.wang:intel.com' => 'Zhenyu Z. Wang',
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zli4:cs.uiuc.edu' => 'Zhenmin Li',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
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

