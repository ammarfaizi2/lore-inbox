Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUL2KdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUL2KdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 05:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbUL2KdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 05:33:04 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43410 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261422AbUL2KdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 05:33:00 -0500
Subject: Re: local root exploit confirmed in 2.6.10: Linux 2.6 Kernel
	Capability LSM Module Local Privilege Elevation
From: Lee Revell <rlrevell@joe-job.com>
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041229102532.GB9926@outpost.ds9a.nl>
References: <1104268915.20714.20.camel@krustophenia.net>
	 <20041229102532.GB9926@outpost.ds9a.nl>
Content-Type: text/plain
Date: Wed, 29 Dec 2004 05:32:59 -0500
Message-Id: <1104316379.2984.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-29 at 11:25 +0100, bert hubert wrote:
> On Tue, Dec 28, 2004 at 04:21:55PM -0500, Lee Revell wrote:
> > Frank Barknecht pointed this out on linux-audio-dev, it's a horrible
> > bug, I confirmed it in 2.6.10, and have not seen it mentioned on the
> > list.
> 
> Although this sucks, it should be pointed out that it only grants root to
> users able to force the loading of a certain module, aka 'root'.

Not force the loading of a certain module, but predict when it will be
loaded.  Still, not easy to exploit.

Lee

