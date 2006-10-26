Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161439AbWJZTCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161439AbWJZTCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 15:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWJZTCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 15:02:10 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:2052 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S1161439AbWJZTCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 15:02:06 -0400
Date: Thu, 26 Oct 2006 21:01:42 +0200
From: thunder7@xs4all.nl
To: Inter filmati <interfc@jumpy.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq/powernowd limiting CPU frequency on kernels >=2.6.16
Message-ID: <20061026190142.GA31153@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <001501c6f921$56c3fe40$2b20ff27@flaviopc> <20061026174153.GB18076@amd64.of.nowhere> <001201c6f928$89c9a720$2b20ff27@flaviopc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201c6f928$89c9a720$2b20ff27@flaviopc>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Inter filmati <interfc@jumpy.it>
Date: Thu, Oct 26, 2006 at 07:59:41PM +0200
> >
> >If you care about that changed, try to find out what patch caused this,
> >but in general, there's no support for overclocking in the kernel, and
> >bugreports from overclocked systems are frowned upon.
> >
> It would be kind to find out why the problem seems to show only from 2.6.16 
> and not before, unfortunately I ain't so skilled to investigate into 
> cpufreq source.
> 
You could start by trying 2.6.16-rc1, -rc2, -rc3 and find out in which
kernel it changed. Then, read the changelog for that patch to find out
what changed in the cpufreq driver. So far, no great skill required.
Then, post here, mentioning which patch caused the different behaviour.

Jurriaan
-- 
Despite the best efforts of a quantum bigfoot drive (yes I know everyone
told me they suck, now I know they were right) 2.1.109ac1 is now available
	Alan Cox announcing Linux 2.1.109ac1
Debian (Unstable) GNU/Linux 2.6.18-mm3 2x5042 bogomips load 0.91
