Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWCRScx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWCRScx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWCRScw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 13:32:52 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:61635 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1750795AbWCRScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 13:32:52 -0500
Message-ID: <441C5230.3050904@web.de>
Date: Sat, 18 Mar 2006 19:32:16 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rcX - no more sound with ALSA snd-hda-intel / Sigmatel
References: <441C13C1.7000902@web.de> <20060318143637.GB7471@stusta.de>
In-Reply-To: <20060318143637.GB7471@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

> Does the patch from [1] help?

> [1] http://lkml.org/lkml/2006/3/17/279

Thanks, Adrian! Tried the patch on 2.6.16-rc6-git9, but only headphone 
output is working, now. Microphone not tested, alsamixer/gnome-mixer all 
channels are ok. But internal speakers are quiet, when nothing is to the 
jack connected, is it ok so as a quirk? ;-)

Greetings,
Marcus

