Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbTLVRdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTLVRdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:33:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264439AbTLVRdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:33:44 -0500
Date: Mon, 22 Dec 2003 17:33:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_PCMCIA_PROBE fix
Message-ID: <20031222173341.A29960@flint.arm.linux.org.uk>
Mail-Followup-To: Andres Salomon <dilinger@voxel.net>,
	linux-kernel@vger.kernel.org
References: <1072072123.27831.6.camel@spiral.internal> <20031222094829.B13978@flint.arm.linux.org.uk> <1072113521.919.6.camel@spiral.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1072113521.919.6.camel@spiral.internal>; from dilinger@voxel.net on Mon, Dec 22, 2003 at 12:18:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 12:18:42PM -0500, Andres Salomon wrote:
> On Mon, 2003-12-22 at 04:48, Russell King wrote:
> > Please also note that there /is/ a PCMCIA list which patches should
> > be forwarded to - linux-pcmcia which is at lists.infradead.org
> 
> Please put the list in the MAINTAINERS file; right now, 
> linux-kernel@vger.kernel.org is listed as the relevant list.

Ok, though we do need to find a suitable collection of people willing
to investigate bug reports from users.  Currently I'm receiving most
of the bug reports, though due to hardware limitations I'm unable to
investigate and resolve the vast majority of hardware specific issues.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
