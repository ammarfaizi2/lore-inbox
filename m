Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWBTAag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWBTAag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWBTAag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:30:36 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48071 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751137AbWBTAag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:30:36 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060220002628.GG15608@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe>
	 <200602192323.08169.s0348365@sms.ed.ac.uk>
	 <1140391929.2733.430.camel@mindpipe> <20060219234644.GD15608@elf.ucw.cz>
	 <1140393222.2733.438.camel@mindpipe>  <20060220002628.GG15608@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 19:30:32 -0500
Message-Id: <1140395432.2733.447.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 01:26 +0100, Pavel Machek wrote:
> ...but if I launch plain old aumix, I should be able to unmute it and
> use normally... and that is not the case :-(. 

Do you have a "libasound2"?

Lee

