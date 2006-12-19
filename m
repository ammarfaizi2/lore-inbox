Return-Path: <linux-kernel-owner+w=401wt.eu-S1752749AbWLSPpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbWLSPpL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 10:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbWLSPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 10:45:11 -0500
Received: from smtpout.mac.com ([17.250.248.181]:53688 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbWLSPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 10:45:09 -0500
In-Reply-To: <20061219041159.GA6993@stusta.de>
References: <20061219041159.GA6993@stusta.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C51D50F0-D9DB-464F-9B0B-22516B3DC4B5@mac.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OSS driver removal, 3nd round
Date: Tue, 19 Dec 2006 10:44:32 -0500
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 18, 2006, at 23:11:59, Adrian Bunk wrote:
> 1. ALSA drivers for the same hardware
>
> DMASOUND_PMAC

Acked-By: Kyle Moffett <mrmacman_g4@mac.com>

I don't think I've ever used this sound driver on any of my  
PowerMacs, ranging back to my aged 400MHz box, which is (I believe)  
the only piece of hardware I own which it supports, and the ALSA  
driver plays sound on that system perfectly.  Admittedly the ALSA  
driver's a bit more flaky on my newer G5 and powerbook but I don't  
think the DMASOUND_PMAC driver _ever_ supported those (and I doubt it  
ever will).

Cheers,
Kyle Moffett

