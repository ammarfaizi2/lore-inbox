Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbUKTJv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUKTJv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 04:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKTJv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 04:51:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19718 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261344AbUKTJvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 04:51:46 -0500
Date: Sat, 20 Nov 2004 09:51:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michal Rokos <michal@rokos.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2.6] PCMCIA ds - Exclude uneeded code when ! CONFIG_PROC_FS
Message-ID: <20041120095136.E7482@flint.arm.linux.org.uk>
Mail-Followup-To: Michal Rokos <michal@rokos.info>,
	linux-kernel@vger.kernel.org
References: <200410151434.58571.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410151434.58571.michal@rokos.info>; from michal@rokos.info on Fri, Oct 15, 2004 at 02:34:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 02:34:58PM +0200, Michal Rokos wrote:
> just a oneliner to remove unneeded definition that is done below in the 
> code anyway.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
