Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbULEXi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbULEXi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULEXi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:38:58 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:64492 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261424AbULEXir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:38:47 -0500
Date: Mon, 6 Dec 2004 00:37:56 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Dorn Hetzel <kernel@dorn.hetzel.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: r8169.c
Message-ID: <20041205233756.GB29236@electric-eye.fr.zoreil.com>
References: <20041119162920.GA26836@lilah.hetzel.org> <20041119201203.GA13522@electric-eye.fr.zoreil.com> <20041120003754.GA32133@lilah.hetzel.org> <20041120002946.GA18059@electric-eye.fr.zoreil.com> <20041122181307.GA3625@lilah.hetzel.org> <20041205235519.GA21885@lilah.hetzel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041205235519.GA21885@lilah.hetzel.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dorn Hetzel <kernel@dorn.hetzel.org> :
[...]
> I was wondering if the above 4 patches have made it into one of the
> rc? releases, or at least a rc?-mm?  ?

They need to apply on top of -netdev which is included in -mm.
I'll send the patch for inclusion in -mm so there is no need for
Jeff to hurry.

--
Ueimor
