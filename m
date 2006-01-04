Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWADTaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWADTaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWADTaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:30:16 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:20231 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S1751274AbWADTaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:30:14 -0500
In-Reply-To: <20060104191750.798af1da@mango.fruits.de>
References: <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl> <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl> <20060104113726.3bd7a649@mango.fruits.de> <s5hsls398uv.wl%tiwai@suse.de> <20060104191750.798af1da@mango.fruits.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <74F7C515-831F-42E4-9A6F-70A9C11E8BB3@neostrada.pl>
Cc: Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Wed, 4 Jan 2006 20:28:59 +0100
To: Florian Schmidt <tapas@affenbande.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-04, at 19:17, Florian Schmidt wrote:
> Maybe create a /proc control, so users can revert
> to the olde behaviour if there really is any need.

YES YES! After all who doesn't use his system logged in as root?

