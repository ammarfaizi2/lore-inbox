Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUKSBDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUKSBDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUKRSq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:46:56 -0500
Received: from havoc.gtf.org ([69.28.190.101]:16870 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262864AbUKRSp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:45:26 -0500
Date: Thu, 18 Nov 2004 13:45:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
Message-ID: <20041118184524.GA19606@havoc.gtf.org>
References: <20041117163016.A5351@tuxdriver.com> <20041117145644.005e54ff.akpm@osdl.org> <419CE98B.2090304@pobox.com> <Pine.LNX.4.53.0411181936050.8260@yvahk01.tjqt.qr> <419CEC33.3010208@pobox.com> <Pine.LNX.4.53.0411181940580.8260@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411181940580.8260@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 07:41:44PM +0100, Jan Engelhardt wrote:
> >Until it's gone, the current users would prefer not-broken to broken.
> 
> Well, leave it broken and reason it with "come over to ALSA".

i810 audio still locks up in ALSA ATM...

	Jeff



