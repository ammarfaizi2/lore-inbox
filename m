Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUDPQDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUDPQDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:03:07 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:18067 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263366AbUDPQDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:03:03 -0400
Date: Fri, 16 Apr 2004 17:02:08 +0100
From: Dave Jones <davej@redhat.com>
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.5] agp_backend_initialize() failed
Message-ID: <20040416160208.GA25240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paul Rolland <rol@as2917.net>, linux-kernel@vger.kernel.org
References: <200404161522.i3GFMa118998@tag.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404161522.i3GFMa118998@tag.witbe.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 05:22:34PM +0200, Paul Rolland wrote:
 > Hello,
 > 
 > I juste realized that my messages log contains :
 > 
 > Linux agpgart interface v0.100 (c) Dave Jones
 > agpgart: Detected SiS 648 chipset
 > agpgart: Maximum main memory to use for agp memory: 1430M
 > agpgart: unable to determine aperture size.
 > agpgart: agp_backend_initialize() failed.
 > agpgart-sis: probe of 0000:00:00.0 failed with error -22

Should be fixed in 2.6.6-rc1

		Dave

