Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275061AbTHLGJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275062AbTHLGJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:09:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:38672 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S275061AbTHLGJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:09:51 -0400
Date: Tue, 12 Aug 2003 08:09:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Dave Jones <davej@codemonkey.org.uk>, marcelo@conectiva.com.br,
       fxkuehl@gmx.de, linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: [PATCH][2.4.22-rc2] Disable APIC on reboot.
Message-ID: <20030812060926.GA13069@alpha.home.local>
References: <E19mCuO-0003dI-00@tetrachloride> <16183.50273.723650.136532@gargle.gargle.HOWL> <20030811163834.GA21568@redhat.com> <16183.51974.508883.472043@gargle.gargle.HOWL> <16184.10173.412201.802953@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16184.10173.412201.802953@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

On Tue, Aug 12, 2003 at 01:33:17AM +0200, Mikael Pettersson wrote:
> Here is a patch for 2.4.22-rc2 to disable the local APIC before
> reboot. This fixes BIOS reboot problems reported by a few people.

I can happily confirm that this one makes my VAIO reboot correctly.
Thanks !

Willy

