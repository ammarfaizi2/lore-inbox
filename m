Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWDCP50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWDCP50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWDCP50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:57:26 -0400
Received: from mfc.musees-franchecomte.com ([83.143.18.224]:38282 "EHLO
	mfc.musees-franchecomte.com") by vger.kernel.org with ESMTP
	id S1751758AbWDCP5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:57:25 -0400
Subject: how to use v4l / em2820 | em2840
From: Rakotomandimby Mihamina 
	<mihamina.rakotomandimby@etu.univ-orleans.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 03 Apr 2006 18:00:01 +0200
Message-Id: <1144080001.5919.37.camel@localhost.localdomain>
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

