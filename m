Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWIUOEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWIUOEX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWIUOEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:04:22 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:14877 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750699AbWIUOEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:04:22 -0400
Date: Thu, 21 Sep 2006 16:04:20 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Apple Motion Sensor (was: 2.6.19 -mm merge plans)
Message-ID: <20060921140420.GB7869@hansmi.ch>
References: <20060920135438.d7dd362b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 01:54:38PM -0700, Andrew Morton wrote:
> apple-motion-sensor-driver-2.patch
> apple-motion-sensor-driver-2-fixes-update.patch
> apple-motion-sensor-driver-kconfig-fix.patch

Please wait with those. We're currently trying to come up with a generic
class for all motion sensor drivers in the kernel. This will change the
userland interface again.

Thanks,
Michael
