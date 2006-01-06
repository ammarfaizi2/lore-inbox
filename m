Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWAFNkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWAFNkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWAFNkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:40:16 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:30568 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP id S932409AbWAFNkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:40:14 -0500
Date: Fri, 6 Jan 2006 15:37:32 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Marcin Dalecki <martin@dalecki.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <43BE3E3D.7050506@superbug.demon.co.uk>
Message-ID: <Pine.LNX.4.61.0601061526350.3057@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de>
 <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr>
 <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe>
 <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <1136491503.847.0.camel@mindpipe>
 <7B34B941-46CC-478F-A870-43FE0D3143AB@dalecki.de> <1136493172.847.26.camel@mindpipe>
 <8D670C39-7B52-407C-8BDD-3478DB172641@dalecki.de>
 <9a8748490601051535s5e28fd81of6814088db7ccac@mail.gmail.com>
 <A1ECA9D1-29EB-4C44-A343-87B5EAAD4ADA@dalecki.de>
 <Pine.LNX.4.61.0601060302370.29362@zeus.compusonic.fi>
 <43BE3E3D.7050506@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, James Courtier-Dutton wrote:
> Even you admit that the OSS drivers in the kernel mainline are "really
> obsolete", so you must agree with this thread that we should remove them.
I completely agree. As I said I would like to see the old OSS code to be 
removed from the kernel soon.
 
> Only if your binary blobs are released as GPL so that they can be included in
> mainline can it really be any use to discuss them.
We are planning to release OSS under some open source license (not GPL).
However it will be released and built outside the Linux kernel source tree 
(mostly because the same code has to work with several other operating 
system).

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
