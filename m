Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVG0X6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVG0X6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVG0X6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:58:34 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:40898 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261234AbVG0X62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:58:28 -0400
Date: Wed, 27 Jul 2005 20:58:19 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Zoran Dzelajlija <jelly+news@srk.fer.hr>, linux-kernel@vger.kernel.org,
       linux-sound@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050727235818.GC31781@ime.usp.br>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Zoran Dzelajlija <jelly+news@srk.fer.hr>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <42E6645B.30206@zabbo.net> <20050726233837.459A.3.NOFFLE@islands.iskon.hr> <1122506920.22844.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1122506920.22844.10.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 27 2005, Lee Revell wrote:
> On Wed, 2005-07-27 at 01:38 +0200, Zoran Dzelajlija wrote:
> > The OSS maestro driver works better on my old Armada E500 laptop.
> > I tried ALSA after switching to 2.6, but the computer hung with
> > 2.6.8.1 or 2.6.10 if I touched the volume buttons.
> 
> Please test a newer ALSA version, like the one in 2.6.12.

I have an Armada V300 laptop that uses the maestro2 chipset (and I
wouldn't be surprised if your E500 used that very same chip) and it
works fine with the ALSA provided in kernels since the 2.6.10-mm era
(actually, I think it worked fine with even earlier kernels, but I am
not sure).


Just another datapoint, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
