Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWFJA4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWFJA4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWFJA4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:56:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25049 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030418AbWFJA4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:56:47 -0400
Subject: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1149899665.12687.95.camel@localhost.localdomain>
References: <20060608205048.113800@gmx.net>
	 <1149899665.12687.95.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 20:46:32 -0400
Message-Id: <1149900393.4686.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 10:34 +1000, Benjamin Herrenschmidt wrote:
> > This leads me to the question, if there are any plans to include the dma_mmap_coherent() function (for powerpc/ppc and/or any other platform) in one of the next kernel versions and if an adapation of the ALSA drivers is planned. Or is there a simple way (hack) to fix this problem?
> 
> You are welcome to do a patch implementing this :)

Please cc: alsa-devel when you do so.

Lee

