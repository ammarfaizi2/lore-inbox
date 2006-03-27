Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWC0C0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWC0C0i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 21:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWC0C0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 21:26:38 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10466 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751584AbWC0C0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 21:26:37 -0500
Subject: Re: [Alsa-devel] nm256: register strangeness related to lockups
From: Lee Revell <rlrevell@joe-job.com>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060326182607.GB11408@hermes.uziel.local>
References: <20060326182607.GB11408@hermes.uziel.local>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 21:26:31 -0500
Message-Id: <1143426392.1792.167.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 20:26 +0200, Christian Trefzer wrote:
> Hi folks,
> 
> in the process of analyzing the frequent crashes during the snd-nm256
> module insertion I stumbled across the following register values
> (reading 32bit words at a time in a loop with pcitweak):

Just to make sure, you are testing with 1.0.11-rc4 or CVS?  The nm256
lockup problems were thought to be fixed.  Or is this a different bug?

Lee

