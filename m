Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVC3VLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVC3VLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVC3VLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:11:24 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9358 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261773AbVC3VJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:09:03 -0500
Date: Wed, 30 Mar 2005 23:06:46 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@muc.de>, Asfand Yar Qazi <ay1204@qazi.f2s.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
Message-ID: <20050330210646.GA26746@electric-eye.fr.zoreil.com>
References: <4242865D.90800@qazi.f2s.com> <20050324093032.GA14022@havoc.gtf.org> <20050324162706.GJ17865@csclub.uwaterloo.ca> <42432A9F.3090507@pobox.com> <m1ekdz3hz0.fsf@muc.de> <424B013B.3010109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B013B.3010109@pobox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
> Andi Kleen wrote:
[r8169 driver]
> >It does not seem to support DAC (or rather it breaks with DAC enabled), 
> >which makes it not very useful on any machine with >3GB of memory.
> 
> Driver bug.  I can futz with it and get it to do 64-bit on my Athlon64.

Care to send a patch ?

--
Ueimor
