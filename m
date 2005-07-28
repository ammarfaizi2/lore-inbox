Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVG1Shd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVG1Shd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVG1Se4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:34:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27277 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261939AbVG1Sda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:33:30 -0400
Subject: Re: [Alsa-devel] Re: [2.6 patch] schedule obsolete OSS drivers for
	removal
From: Lee Revell <rlrevell@joe-job.com>
To: Thorsten Knabe <linux@thorsten-knabe.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
References: <20050726150837.GT3160@stusta.de>
	 <Pine.LNX.4.61.0507281636040.20815@tek01.intern.thorsten-knabe.de>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 14:33:26 -0400
Message-Id: <1122575607.2772.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 17:04 +0200, Thorsten Knabe wrote:
> I'm the maintainer of the OSS AD1816 sound driver. I'm aware of two 
> problems of the ALSA AD1816 driver, that do not show up with the OSS 
> driver:
> - According to my own experience and user reports audio is choppy with 
> some VoIP Softphones like gnophone at least when used with the ALSA OSS 
> emulation layer, whereas the OSS driver is crystal clear.
> - Users reported, that on some HP Kayak systems the on-board AD1816A 
> was not properly detected by the ALSA driver or was detected, but 
> there was no audio output. I'm not sure if the problem is still present in 
> the current ALSA driver, as I do not own such a system.

What are the bug id #s in the ALSA BTS?  If it's not in the bug tracker
it's never going to get fixed.

Lee

