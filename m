Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbUK3AWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUK3AWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUK3AWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:22:14 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:10398 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261883AbUK3AWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:22:11 -0500
Date: Tue, 30 Nov 2004 01:21:27 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Terry Griffin <terryg@axian.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: odd behavior with r8169 and pcap
Message-ID: <20041130002127.GC3880@electric-eye.fr.zoreil.com>
References: <1101751909.2291.21.camel@tux.hq.axian.com> <20041129210213.GA3880@electric-eye.fr.zoreil.com> <1101766059.3382.57.camel@tux.hq.axian.com> <20041129231800.GB3880@electric-eye.fr.zoreil.com> <1101772869.3382.101.camel@tux.hq.axian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101772869.3382.101.camel@tux.hq.axian.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Griffin <terryg@axian.com> :
[...]
> Passing acpi=off did the trick. Throughput is at the higher rate
> with or without pcap monitoring. I did not have to change any BIOS
> settings.

As a longer term solution, something can surely be extracted from
the acpi tables of your computer. See
http://forums.gentoo.org/viewtopic.php?t=122145%22%22 for an intro.

--
Ueimor
