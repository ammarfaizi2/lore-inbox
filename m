Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUFPQTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUFPQTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUFPQTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:19:20 -0400
Received: from pop.gmx.net ([213.165.64.20]:64128 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263984AbUFPQTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:19:18 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.7
Date: Wed, 16 Jun 2004 18:31:39 +0200
User-Agent: KMail/1.6.2
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406161831.40494.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 June 2004 07:56, Linus Torvalds wrote:
> Ok, it's out there. The most notable change may be the one-liner that
> should fix the embarrassing FP exception problem. Other than that, we've
> had a random collection of fixes and updates since rc3. cifs, ntfs,
> cpufreq. ide, sparc, s390.
>
> Full 2.6.6->2.6.7 changelog available at the same places the release is.
>
> 		Linus

Is there any reason why the sis900-fix-phy-transceiver-detection.patch wasn't 
moved to the stable tree? It's a now for a long time in -mm patches and 
without that patch, a lot of sis900 cards does not work in full-duplex 
100Tx-FD mode.

greets dominik
