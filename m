Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVATJ3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVATJ3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 04:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVATJ2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 04:28:42 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:40344 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262086AbVATJ2H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 04:28:07 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_20_Jan_2005_09_27_58_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050120092758.85EFE77991@merlin.emma.line.org>
Date: Thu, 20 Jan 2005 10:27:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.263, 2005-01-20 06:37:30+01:00, samel@mail.cz
  shortlog: added 35 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+)

##### GNUPATCH #####
--- 1.231/shortlog	2005-01-12 05:57:15 +01:00
+++ 1.232/shortlog	2005-01-20 06:37:08 +01:00
@@ -400,6 +400,7 @@
 'bde:bwlink.com' => 'Bruce D. Elliott',	# it's typo IMHO
 'bde:nwlink.com' => 'Bruce D. Elliott',
 'bdschuym:pandora.be' => 'Bart De Schuymer',
+'bdschuym:telenet.be' => 'Bart De Schuymer',
 'bdshuym:pandora.be' => 'Bart De Schuymer', # it's typo IMHO
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'becky.gill:freescale.com' => 'Becky Gill',
@@ -481,6 +482,7 @@
 'bunk:de.rmk.(none)' => 'Adrian Bunk', # guessed
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'bunk:stusta.de' => 'Adrian Bunk',
+'bunk:stutsa.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'buytenh:org.rmk.(none)' => 'Lennert Buytenhek',
 'buytenh:wantstofly.org' => 'Lennert Buytenhek',
@@ -624,6 +626,7 @@
 'dalecki:evision.ag' => 'Martin Dalecki',
 'dalto:austin.ibm.com' => 'Dave Altobelli',
 'damien.morange:hp.com' => 'Damien Morange',
+'damm:opensource.se' => 'Magnus Damm',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
 'dan:embeddededge.com' => 'Dan Malek',
@@ -794,6 +797,7 @@
 'ecashin:coraid.com' => 'Ed L. Cashin',
 'ecashin:uga.edu' => 'Ed L. Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
+'echtler:fs.tum.de' => 'Florian Echtler',
 'ed:il.fontys.nl' => 'Ed Schouten',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
 'edrossma:us.ibm.com' => 'Eric Rossman',
@@ -830,6 +834,7 @@
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
 'engel:us.ibm.com' => 'John Engel',
+'enrico.scholz:informatik.tu-chemnitz.de' => 'Enrico Scholz',
 'eolson:mit.edu' => 'Edwin Olson',
 'eradicator:gentoo.org' => 'Jeremy Huddleston',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
@@ -885,6 +890,7 @@
 'fl:fl.priv.at' => 'Friedrich Lobenstock',
 'flavien:lebarbe.net' => 'Flavien Lebarbé',
 'fletch:aracnet.com' => 'Martin J. Bligh',
+'fli:ati.com' => 'Frederick Li',
 'flo:rfc822.org' => 'Florian Lohoff',
 'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
 'florin:iucha.net' => 'Florin Iucha',
@@ -897,6 +903,7 @@
 'francis.wiran:hp.com' => 'Francis Wiran',
 'frank.a.uepping:t-online.de' => 'Frank A. Uepping',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
+'frank:tuxrocks.com' => 'Frank Sorenson',
 'frank_borich:us.xyratex.com' => 'Frank Borich',
 'frankie:cse.unsw.edu.au' => 'Frank Engel',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
@@ -914,6 +921,7 @@
 'fzago:austin.rr.com' => 'Frank Zago', # google
 'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
 'gaa:ulticom.com' => 'Gary Algier', # google
+'gaboregry:axelero.hu' => 'Gabor Egry',
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
 'galak:linen.sps.mot.com' => 'Kumar Gala',
 'galak:somerset.sps.mot.com' => 'Kumar Gala',
@@ -947,6 +955,7 @@
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
+'giorgio:org.rmk.(none)' => 'Giorgio Padrin',
 'giri:lmc.cs.sunysb.edu' => 'Giridhar Pemmasani',
 'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
 'giuseppe:eppesuigoccas.homedns.org' => 'Giuseppe Sacco',
@@ -972,6 +981,7 @@
 'gortmaker:yahoo.com' => 'Paul Gortmaker',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
+'grantma:anathoth.gen.nz' => 'Matthew Grant',
 'greearb:candelatech.com' => 'Ben Greear',
 'green:angband.namesys.com' => 'Oleg Drokin',
 'green:linuxhacker.ru' => 'Oleg Drokin',
@@ -993,6 +1003,7 @@
 'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
+'gunther.mayer:gmx.net' => 'Gunther Mayer',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'gwurster:scs.carleton.ca' => 'Glenn Wurster',
 'h.schurig:de.rmk.(none)' => 'Holger Schurig',
@@ -1004,6 +1015,7 @@
 'hadi:znyx.com' => 'Jamal Hadi Salim', # typo
 'hadi:zynx.com' => 'Jamal Hadi Salim',
 'hall:vdata.com' => 'Jeff Hall',
+'halr:voltaire.com' => 'Hal Rosenstock',
 'hammer:adaptec.com' => 'Jack Hammer',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
 'hanno:gmx.de' => 'Hanno Böck',
@@ -1045,6 +1057,7 @@
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hero:persua.de' => 'Heiko Ronsdorf',
 'herry:sgi.com' => 'Herry Wiputra',
+'hfvogt:arcor.de' => 'Hans-Frieder Vogt',
 'hifumi.hisashi:lab.ntt.co.jp' => 'Hisashi Hifumi',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hiroshi_doyu:montavista.co.jp' => 'Hiroshi Doyu',
@@ -1200,6 +1213,7 @@
 'jeremy:redfishsoftware.com.au' => 'Jeremy Kerr',
 'jeremy:sgi.com' => 'Jeremy Higdon',
 'jermar:itbs.cz' => 'Jakub Jermar',
+'jerome.forissier:hp.com' => 'Jerome Forissier',
 'jerone:gmail.com' => 'Jerone Young',
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
@@ -1470,6 +1484,7 @@
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'kyle:debian.org' => 'Kyle McMartin',
 'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
+'kyle:parisc-linux.org' => 'Kyle McMartin',
 'l.rossato:tiscali.it' => 'Luca Rossato',
 'l.s.r:web.de' => 'René Scharfe',
 'ladis:linux-mips.org' => 'Ladislav Michl',
@@ -1577,6 +1592,7 @@
 'luming.yu:intel.com' => 'Luming Yu',
 'lunz:falooley.org' => 'Jason Lunz',
 'luto:myrealbox.com' => 'Andy Lutomirski',
+'lw:de.rmk.(none)' => 'Lothar Wassmann',
 'lxie:us.ibm.com' => 'Linda Xie',
 'lxiep:linux.ibm.com' => 'Linda Xie',
 'lxiep:ltcfwd.linux.ibm.com' => 'Linda Xie',
@@ -1638,6 +1654,7 @@
 'markh:osdl.org' => 'Mark Haverkamp',
 'markhe:veritas.com' => 'Mark Hemment',
 'markus.lidel:shadowconnect.com' => 'Markus Lidel',
+'markzzzsmith:yahoo.com.au' => 'Mark Smith',
 'marr:flex.com' => 'Bill Marr',
 'martin-langer:gmx.de' => 'Martin Langer',
 'martin.bene:icomedias.com' => 'Martin Bene',
@@ -1715,6 +1732,7 @@
 'michael.veeck:gmx.net' => 'Michael Veeck',
 'michael.waychison:sun.com' => 'Mike Waychison',
 'michael:com.rmk.(none)' => 'Michael Opdenacker',
+'michael:ellerman.id.au' => 'Michael Ellerman',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
 'michael_pruznick:mvista.com' => 'Michael Pruznick',
@@ -1807,6 +1825,7 @@
 'mru:kth.se' => 'Måns Rullgård',
 'msalter:redhat.com' => 'Mark Salter',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
+'mst:mellanox.co.il' => 'Michael S. Tsirkin',
 'msw:redhat.com' => 'Matt Wilson',
 'mtk-lkml:gmx.net' => 'Michael Kerrisk',
 'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
@@ -1839,6 +1858,7 @@
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nfont:austin.ibm.com' => 'Nathan Fontenot',
+'nhorman:gmail.com' => 'Neil Horman',
 'nhorman:redhat.com' => 'Neil Horman',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nickpiggin:cyberone.com.au' => 'Nick Piggin',
@@ -1954,6 +1974,7 @@
 'paulus:quango.ozlabs.ibm.com' => 'Paul Mackerras',
 'paulus:samba.org' => 'Paul Mackerras',
 'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
+'pavel (at) ucw.cz' => 'Pavel Machek',
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
@@ -2086,8 +2107,10 @@
 'r.marek:sh.cvut.cz' => 'Rudolf Marek',
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
 'radford:indigita.com' => 'Jim Radford',
+'rafael.espindola:gmail.com' => 'Rafael Ávila de Espíndola',
 'raghavendra.koushik:s2io.com' => 'Raghavendra Koushik',
 'rainer.weikusat:sncag.com' => 'Rainer Weikusat',
+'raivis:mt.lv' => 'Raivis Bucis',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
@@ -2139,7 +2162,9 @@
 'riel:imladris.surriel.com' => 'Rik van Riel',
 'riel:redhat.com' => 'Rik van Riel',
 'riel:surriel.com' => 'Rik van Riel',
+'rja:sgi.com' => 'Russ Anderson',
 'rjmx:rjmx.net' => 'Ron Murray',
+'rjw:sisk.pl' => 'Rafael J. Wysocki',
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rkagan:mail.ru' => 'Roman Kagan',
 'rl:hellgate.ch' => 'Roger Luethi',
@@ -2267,6 +2292,7 @@
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott:concord.org' => 'Scott Cytacki',
 'scott:pantastik.com' => 'Scott Russell',
+'scott:sonic.net' => 'Scott Doty',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
@@ -2276,6 +2302,7 @@
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
 'se.witt:gmx.net' => 'Sebastian Witt',
+'sean.hefty:intel.com' => 'Sean Hefty',
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
 'sean:mess.org' => 'Sean Young',
 'seanlkml:rogers.com' => 'Sean Estabrooks',
@@ -2381,6 +2408,7 @@
 'starvik:axis.com' => 'Mikael Starvik',
 'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
+'stefan.macher:web.de' => 'Stefan Macher',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
@@ -2455,10 +2483,14 @@
 'tapio:iptime.fi' => 'Tapio Laxström',
 'taral:taral.net' => 'Jean-Philippe Sugarbroad', # Muli Ben-Yehuda on lk
 'tausq:debian.org' => 'Randolph Chung',
+'tausq:parisc-linux.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tchen:on-go.com' => 'Thomas Chen',
+'tduffy:sun.com' => 'Tom Duffy',
 'teanropo:cc.jyu.fi' => 'Tero Roponen',
 'tejohnson:yahoo.com' => 'Todd E. Johnson',
+'temnota+kernel:kmv.ru' => 'Andrey Melnikov',
+'temnota:kmv.ru' => 'Andrey Melnikov',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'tglx:linutronix.de' => 'Thomas Gleixner',
@@ -2604,6 +2636,7 @@
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vladimir.grouzdev:jaluna.com' => 'Vladimir Grouzdev',
+'vladislav.yasevich:hp.com' => 'Vladislav Yasevich',
 'vlobanov:speakeasy.net' => 'Vadim Lobanov',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
@@ -2623,6 +2656,7 @@
 'waltabbyh:comcast.net' => 'Walt Holman',
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
 'wang:ai.mit.edu' => 'Edward Wang',
+'wangzhongjun:ccoss.com.cn' => 'Wang Zhongjun',
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
@@ -2655,6 +2689,7 @@
 'willy:fc.hp.com' => 'Matthew Wilcox',
 'willy:org.rmk' => 'Matthew Wilcox',
 'willy:org.rmk.(none)' => 'Matthew Wilcox',
+'willy:parisc-linux.org' => 'Matthew Wilcox',
 'willy:w.ods.org' => 'Willy Tarreau',
 'wilsonc:abocom.com.tw' => 'Wilson Chen', # google
 'wim:iguana.be' => 'Wim Van Sebroeck',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAJ5570ECA7VW7W7bNhT9HT0Fgf5Ii84MJVmWRSBFkyZt+pGtSNoG2z9aoi3WFOmRlL/g
l9sD7R12SfmjyRYM27o4MGCec8h7z7280hP09oIeOW3mTFb25YyrSSsUdoYp23DHcKmbzaua
qQm/5W6TEJLAJ05SMsiKTVIMsmzDE55lZT9mo3yY8zKJnqDPlht61DDnasEsZqoynMP6lbaO
Hk2aJa78zxut4efJnJmTkXBTzmfcnJy/7025UVz2nNbSRsD7yFxZozk3lh7FON2vuNWM06Ob
yzefP5zdRNHpKdqHik5Po++c1mG7WVnkBGtbSazN5P5GGYnjhPSzPB5sBllKiugCxTgZpIhk
JyQ+SQgiA5rmNCXPSUwJQZY1XL5smJC4XKPnMeqR6Bx95+BfRSWytTZO6glFrKp4hdIMKb7w
Pwy3ltvoPRr00ziJPh58jHr/8C+KCCPRi0P8tW74g+B3gXSxZ/GQ5P08Hm7SOC+yzZgXbFzm
pGCEV2xU3TfonhjM9t9pTkCcg+WhCXaMez3wn8N4vP4PItqWP9v040ERd+VPk4flJ8O/Lj8U
5f+q/6NV76z7CfXMYun/e0togV1W/6ID3vZJguLoeFTZsm5XDXVccsUdHvFjdPoCHZ8z49AF
R7cB5ub4B9AM06Bp1ZRa1zrLYEh09LPKCKbQOUCeOUgGnlmxpqEa7LG6NSXHdsu+ZhPVWnQB
sGfnRWDzsnYSptLYYtc2+61fSx32vuxgLximIXiujCg1hgy0XFOhxtrAQBNTkPfKmjdKuPV+
m8tA9vkAOWwyzP0mYykoiHzJtucZXnHgTtEHEXhFEXhQ3Cl17dLocmq/pcM6utXGZ6m8oIhD
OhM2gsWJWVG2BHONxnXbSd54BF0CFOj9sP9EQKMKTeEbm2aKnyqt+LOtoMNgpoLN3Rl5P4jg
cNcwyhRztXY1nnCF1XrnMgx36KM3nhRERRZErYJ1gxu2Arf9qIfCbw/qIHTtIS+JCQnJ1Ewa
OtfSMWH4IfkrJuERYSF1B650gn6wtR7P9cRRZkpt9jW4gvvRe22ENxh9ATwokq4Vv4JFMACg
iMJaAZHVs8NB7wKIXu/AIOznQThdSU5nDJCyJ4Vql/7Kd7L3AKHr8hqaufMtzvLgtlzQiv/J
5w9gITPojlnbMNUJBn3iBQ0z0/V6bRvharpitdY+OMzandcGmsCDQZTHwYRGlDXjknIJ9Ycd
sagOig5Dl1ss6IYkRNfAMxhGjmRKL+EYLOR9zS1Gn6ww021Ow37sVar2/a+gomFS7az7kQsJ
j/X9GUUWKjpjc9jpKXPPUFsuYLB17I9h+ZrB/Qn1TMhw6OmGjeFkzO1MqEpL9vCUm4Cj3+ZC
MlRxdGlnvwdit0lBuk3EXFjaOCznO5lfgblRChuYcZeL+cqonXxzK29aa9GZgsbZ3jJgJh1z
Qa2wUzyT9yJ5h9HdykJXhkucJIPgrC21cxS2EOWh62/9IrrQbtVR85Cx5VCwmo/dCkYLjMdD
LLeAoCuPBH7ajUXr+BgUjbfO0AUf7dv+NiCdqaFzE3j6eIljrf31kda9Yd6+WQ0P+lZNtqqQ
g6va8XhFbasOIX3SDbrwyx1xEKMEiDACtWPPu5c1Om3m2Gy778y/763QNZdKTPUcVDv239De
JoNuIswlq4SVbI5XzPI5dOa9C/tlB6Oft3AnTsIIWsCjcV1rNfnaKlqW2oaBikvVie8ARr9s
8U7XGbYQUq4eMWw37u6ELPUSVPuXULAdRnbbnI7SgqfZiEV/ALqNPxpVCwAA

