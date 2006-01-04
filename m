Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWADMfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWADMfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 07:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWADMfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 07:35:45 -0500
Received: from cantor2.suse.de ([195.135.220.15]:19843 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030219AbWADMfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 07:35:44 -0500
Date: Wed, 4 Jan 2006 13:35:38 +0100
From: Andi Kleen <ak@suse.de>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>, Adrian Bunk <bunk@stusta.de>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060104123538.GE7222@wotan.suse.de>
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk> <20060103192449.GA26030@dspnet.fr.eu.org> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <43BBBBFF.5020209@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BBBBFF.5020209@folkwang-hochschule.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> desktop stuff and "you have mail" beeps are a fscking corner case.

Your "fscking corner case" is just all what 90+% of all users need
sound for.

> 
> this is like whining about the oh so complex networking infrastructure 
> and iptables and constantly reminiscing how simple it used to be to set 
> up a modem on /dev/ttyS0.

Can be nearly all CONFIGured out. With the removal of the sane
sound drivers that would be impossible though.

-Andi

