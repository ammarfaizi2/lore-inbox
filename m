Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWDAWNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWDAWNh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 17:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWDAWNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 17:13:37 -0500
Received: from mfc.musees-franchecomte.com ([83.143.18.224]:40675 "EHLO
	mfc.musees-franchecomte.com") by vger.kernel.org with ESMTP
	id S1751145AbWDAWNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 17:13:36 -0500
Subject: how to use v4l / em2820 | em2840
From: Rakotomandimby Mihamina 
	<mihamina.rakotomandimby@etu.univ-orleans.fr>
Reply-To: Rakotomandimby Mihamina 
	  <mihamina.rakotomandimby@etu.univ-orleans.fr>
To: video4linux-list@redhat.com, vlc@videolan.org,
       linux-kernel@vger.kernel.org, fedora-list@redhat.com,
       debian-user@lists.debian.org
Cc: mrechberger@gmail.com, marillat@free.fr
Content-Type: text/plain
Date: Sun, 02 Apr 2006 00:15:50 +0200
Message-Id: <1143929750.4978.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-3.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just bougth a Pinnacle Dazzle DV90 USB device:
http://www.mwave.com/mwave/skusearch.hmx?SCriteria=3491061&CartID=done&nextloc=
It is known to work on Linux:
http://www.linuxhq.com/kernel/v2.6/15/Documentation/video4linux/CARDLIST.em28xx

The problem... I did not find any documentation about how to use the
module, to acquire some video + audio with this device.
- I should load em2820
- What others modules have I got to load too?
- Then what command line to perform to save the capture to a file?
	( what is the /dev/foo/bar? ....)

I dont use any particular distribution for the moment, but ask to all
the MLs.
Thank you for your help.
The reply-to is set to me first but I will merge all the information
into a tutorial if I get ver it.
-- 
A powerfull GroupWare, CMS, CRM, ECM: CPS (Open Source & GPL).
Opengroupware, SPIP, Plone, PhpBB, JetSpeed... are good: CPS is better.
http://www.cps-project.org for downloads & documentation.

