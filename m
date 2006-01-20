Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161428AbWATC4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161428AbWATC4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbWATCzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:40 -0500
Received: from codepoet.org ([166.70.99.138]:11479 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1161469AbWATCzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:14 -0500
Date: Thu, 19 Jan 2006 19:55:13 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060120025513.GA2438@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, perex@suse.cz
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137709308.8471.77.camel@localhost.localdomain> <20060119224501.GC19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119224501.GC19398@stusta.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 19, 2006 at 11:45:01PM +0100, Adrian Bunk wrote:
> config SOUND_WAVEARTIST
>         tristate "Netwinder WaveArtist"
>         depends on ARM && SOUND_OSS && ARCH_NETWINDER
>         help
>           Say Y here to include support for the Rockwell WaveArtist sound
>           system.  This driver is mainly for the NetWinder.

I own two netwinders (strongArm SA110) and I would be glad to
fire them up to test things if someone feels like writing a
driver....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
