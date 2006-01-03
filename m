Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWACOua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWACOua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWACOua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:50:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20130 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932394AbWACOu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:50:28 -0500
Date: Tue, 3 Jan 2006 15:50:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <200601031441.27519.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0601031548210.436@yvahk01.tjqt.qr>
References: <20050726150837.GT3160@stusta.de> <200601031347.19328.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.61.0601031530240.436@yvahk01.tjqt.qr> <200601031441.27519.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The problem with using OSS compatibility, at least on this machine with ALSA 
>1.0.9, is that if you use it you automatically lose the software mixing 
>capabilities of ALSA, so it really is less than ideal.
>

Well, I am able to open /dev/dsp multiple times here without problems.
(Is /dev/dsp soft- or hardmixing?)



Jan Engelhardt
-- 
