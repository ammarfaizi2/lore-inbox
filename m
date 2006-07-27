Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWG0VGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWG0VGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWG0VGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:06:20 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:36325 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751048AbWG0VB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:01:26 -0400
Date: Thu, 27 Jul 2006 23:01:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Michael Elizabeth Chastain <mec@shout.net>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linguistic fixes for Documentation/kbuild/
Message-ID: <20060727210110.GA4547@mars.ravnborg.org>
References: <Pine.LNX.4.61.0607272208110.29115@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0607272208110.29115@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 10:14:29PM +0200, Jan Engelhardt wrote:
> Hello,
> 
> 
> I have done a look-through through Documentation/kbuild/ and my corrections 
> (proposed) are attached. It is bzipped because the uncompressed diff is 
> 41KB and may have get stuck on the magic list limit (30 or 40, I believe 40).
> 
> Cc'ed are original author Michael (responsible for comitting changes to 
> these files?), Sam (kbuild maintainer), Adrian (-trivial maintainer).

Applied - as three individual patches.
Roman Zippel takes care of kconfig-language. The two others are mostly
me who introduce speling mistakes et al.

Thanks!
	Sam
