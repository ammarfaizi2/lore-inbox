Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWANT2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWANT2D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWANT2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:28:03 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:46536 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750834AbWANT2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:28:02 -0500
Subject: Re: PROBLEM: PCI WiFi card works with livecd's but not with HD
	install with Ali mobo.
From: Lee Revell <rlrevell@joe-job.com>
To: Matthew Marshall <lists@matthewmarshall.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601141605.34891.lists@matthewmarshall.org>
References: <200601141427.36915.matthew@matthewmarshall.org>
	 <200601141445.49962.matthew@matthewmarshall.org>
	 <1137260799.1408.58.camel@mindpipe>
	 <200601141605.34891.lists@matthewmarshall.org>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 14:27:55 -0500
Message-Id: <1137266876.19972.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 16:05 -0300, Matthew Marshall wrote:
> I tried it with both an Ethernet adapter (realtek) and a pci sound
> card (Creative SoundBlaster.)  

Unfortunately "Creative PCI Soundblaster" is no longer enough
information for us to identify the chipset, since Creative started
marketing the (inferior) CA0106 devices as "SoundBlaster Live!" as well.

Please report your soundcard problem to the alsa-user list and include
the output of "lspci -vn | grep -A1 0401".

Lee

