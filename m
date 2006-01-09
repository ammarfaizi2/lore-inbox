Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWAIQWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWAIQWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWAIQWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:22:14 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5348 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964861AbWAIQWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:22:13 -0500
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: vherva@vianova.fi
Cc: Florian Schmidt <tapas@affenbande.org>,
       Tomasz =?ISO-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060109162106.GW21365@vianova.fi>
References: <20060104113726.3bd7a649@mango.fruits.de>
	 <1136445395.24475.17.camel@mindpipe>
	 <20060105124317.2d12a85c@mango.fruits.de>
	 <1136483330.31583.5.camel@mindpipe> <20060108210756.GD1686@vianova.fi>
	 <1136756669.2997.2.camel@mindpipe> <20060109081646.GG21365@vianova.fi>
	 <1136814731.9957.4.camel@mindpipe> <20060109142239.GR21365@vianova.fi>
	 <1136819894.9957.16.camel@mindpipe>  <20060109162106.GW21365@vianova.fi>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 11:22:08 -0500
Message-Id: <1136823729.9957.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 18:21 +0200, Ville Herva wrote:
> Revo51 is ICE1724 based. I gather I still need the asoundrc config to get
> some kind of mixing, right? At least it doesn't work without (and with it,
> it badly stutters right now.)

Try the latest ALSA CVS code.

Lee


