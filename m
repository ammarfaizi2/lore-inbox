Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVBWOnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVBWOnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 09:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVBWOnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 09:43:46 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:65193 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261239AbVBWOnl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 09:43:41 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed,_23_Feb_2005_14_43_33_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050223144333.0B658797D3@merlin.emma.line.org>
Date: Wed, 23 Feb 2005 15:43:33 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is file://var/bitkeeper/BK-kernel-tools

Patch description:
ChangeSet@1.274, 2005-02-23 15:43:14+01:00, matthias.andree@gmx.de
  Add six new address -> name mappings.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    6 ++++++
 1 files changed, 6 insertions(+)

##### GNUPATCH #####
--- 1.241/shortlog	2005-02-09 10:22:16 +01:00
+++ 1.242/shortlog	2005-02-23 15:43:14 +01:00
@@ -116,6 +116,7 @@
 'davej:codemonkey.org.u' => 'Dave Jones',
 'davej:codemonkey.org.uk' => 'Dave Jones',
 'davej:delerium.codemonkey.org.uk' => 'Dave Jones',
+'davej:delerium.kernelslacker.org' => 'Dave Jones',
 'davej:wopr.codemonkey.org.uk' => 'Dave Jones',
 'davem:cheetah.ninka.net' => 'David S. Miller',
 'davem:nuts.ninka.net' => 'David S. Miller',
@@ -438,6 +439,7 @@
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
 'bjoern:j3e.de' => 'Bjoern Jacke',
 'bjohnson:sgi.com' => 'Brian J. Johnson',
+'bjorn-helgaas:comcast.net' => 'Bjorn Helgaas',
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
 'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
@@ -945,6 +947,7 @@
 'ganesh:veritas.com' => 'Ganesh Varadarajan',
 'ganesh:vxindia.veritas.com' => 'Ganesh Varadarajan',
 'garloff:suse.de' => 'Kurt Garloff',
+'gary.spiess:intermec.com' => 'Gary N. Spiess',
 'gary_lerhaupt:dell.com' => 'Gary Lerhaupt',
 'garyhade:us.ibm.com' => 'Gary Hade',
 'gbarzini:virata.com' => 'Guido Barzini',
@@ -1783,6 +1786,7 @@
 'mikma:users.sourceforge.net' => 'Mikael Magnusson',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
 'mikpe:user.it.uu.se' => 'Mikael Pettersson',
+'mikukkon:gmail.com' => 'Mika Kukkonen',
 'mikulas:artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
 'miles:gnu.org' => 'Miles Bader',
 'miles:lsi.nec.co.jp' => 'Miles Bader',
@@ -2158,6 +2162,7 @@
 'rathamahata:php4.ru' => 'Sergey S. Kostyliov',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'raven:themaw.net' => 'Ian Kent',
+'ravinandan.arakali:neterion.com' => 'Ravinandan Arakali',
 'ravinandan.arakali:s2io.com' => 'Ravinandan Arakali',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -2530,6 +2535,7 @@
 'temnota:kmv.ru' => 'Andrey Melnikov',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
+'tglx:de.rmk.(none)' => 'Thomas Gleixner',
 'tglx:linutronix.de' => 'Thomas Gleixner',
 'tgraf:suug.ch' => 'Thomas Graf',
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAJWWHEICA8VU7U7bMBT9XT+FJX50E4trO0nTRCoCxgSMfaAyHuA2uaQhiV3ZaSlSHn5O
M1qBNGlsSMuHFPvec33P8YkP6OVZMmi0WUOV2eMlqnxVKNYYULbGBliq6/bjAlSON9i0knPp
biF9Pg7jVsbjMGxRYhimgYB5NIkwleSA3lo0yaCGplkUYBmozCC6+Qttm2SQ1xuWdcOZ1m44
siuLoxKNwmp0euUerx94jdaVJS7xGpp0QddobDIQzN/NNI9LTAazT+e3X05mhEyndNcrnU7J
G/Pal1umccSZtlnFtMmfFwq5FKGIROxH7TiUMiJnVDAZBZSHIy5H0qciTAI/EcEhFwnn9IVO
x70+9FBQj5NT+sYsPpKUnmQZtcWGKnygkLlFraXeEVVQo+tmuSxUbhm5oq5/Icn1XlXivfIi
hAMnR3sSC13jCwZ2oU1T6bwnEIoJj4JITFpfRHHY3mEMd2nEY+CYwTz7jVzPqrg9kL4IAve6
KiLwt954ynhmjX/uh/xZPzzmsZRi3PKxGP/yRCBf7Ynxf/dEr+d36pmHTfd4G2eQJ7J/4Y9L
ISZUkGEGa7xPMqzQFKua9UeArSB1X91fNqTTIzo8c1n0s1Zohx/IZRDwDjq/10Z5C6xyAJs4
AVKwDVPY9JjTLkwv+nAHi4Oog+VgHpldFo5pUqgGTY1pJ1+POndR+o3Rm21CBxPRJOxwdVGu
ylKrJK+hqPaIr0UJ9GobQtUB3HZv+zOwLpTbSFAMDJRQFYlrzvHUao+e7ZLoSZ+0LRH6sivR
5NXGicNMXbJ3yi3wvkf9cP4FS88rLDYKjYPsDsd0gWlpV/U0DgVM7uZAfgLic5DZ7gUAAA==

