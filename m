Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWASWvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWASWvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWASWvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:51:31 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48035 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161359AbWASWva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:51:30 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <20060119224222.GW21663@redhat.com>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe>
	 <1137709135.8471.73.camel@localhost.localdomain>
	 <20060119224222.GW21663@redhat.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 17:51:27 -0500
Message-Id: <1137711088.3241.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 17:42 -0500, Dave Jones wrote:
> 
> (The bug is long-since fixed, but the reporters may still have the
>  hardware and be willing to provide feedback to ALSA developers)
> 

The status is we need someone who has the hardware who can add printk's
to the driver to identify what triggers the hang.  It should not be
hard, the OSS driver reportedly works.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328

The bug has been in FEEDBACK state for a long time.

Lee

