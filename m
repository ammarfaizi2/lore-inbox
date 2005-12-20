Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVLTSI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVLTSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVLTSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:08:56 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:62259 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750817AbVLTSIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:08:55 -0500
Date: Tue, 20 Dec 2005 18:37:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nix <nix@esperi.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Message-ID: <20051220173740.GA9283@mars.ravnborg.org>
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <87d5jru67j.fsf@amaterasu.srvr.nix> <20051220155839.GA9185@mars.ravnborg.org> <87irtjslxx.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87irtjslxx.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 05:44:10PM +0000, Nix wrote:
> cp -al
$ time cp -al linux-2.6 nix
real 0m5.360s

That was second time I did it. It took considerably longer the first
time when nothing was in cache.

	Sam
