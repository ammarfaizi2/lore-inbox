Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbUK2XVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUK2XVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUK2XUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:20:35 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:41629 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261882AbUK2XSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:18:16 -0500
Date: Tue, 30 Nov 2004 00:18:00 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Terry Griffin <terryg@axian.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: odd behavior with r8169 and pcap
Message-ID: <20041129231800.GB3880@electric-eye.fr.zoreil.com>
References: <1101751909.2291.21.camel@tux.hq.axian.com> <20041129210213.GA3880@electric-eye.fr.zoreil.com> <1101766059.3382.57.camel@tux.hq.axian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101766059.3382.57.camel@tux.hq.axian.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Griffin <terryg@axian.com> :
[...]

Ok, thanks for the info. It may sound like voodoo, but...

Could you pass acpi=off to the kernel and disable whatever acpi
or USB option appearing in the bios ?

--
Ueimor
