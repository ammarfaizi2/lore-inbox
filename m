Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVG0UrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVG0UrY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVG0Uoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:44:54 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34754 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262158AbVG0Unv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:43:51 -0400
Message-ID: <42E7F1F9.2050105@pobox.com>
Date: Wed, 27 Jul 2005 16:43:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: Adrian Bunk <bunk@stusta.de>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20050726150837.GT3160@stusta.de> <1122393073.18884.29.camel@mindpipe> <42E65D50.3040808@pobox.com> <20050727182427.GH3160@stusta.de> <20050727203150.GF22686@tuxdriver.com>
In-Reply-To: <20050727203150.GF22686@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> On Wed, Jul 27, 2005 at 08:24:28PM +0200, Adrian Bunk wrote:
> 
> 
>>I've grep'ed a second time for every single PCI ID in the OSS 
>>i810_audio, and I still haven't found WTF you are talking about.
> 
> 
> I looked as well, and I found nothing either.
> 
> Jeff, can you enlighten us?


ISTR Alan saying there was some ALi hardware that either wasn't in ALSA, 
or most likely didn't work in ALSA.  If Alan says I'm smoking crack, 
then you all can ignore me :)

	Jeff


