Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVCISFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVCISFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVCISFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:05:53 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38794 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262120AbVCISFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:05:25 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: szonyi calin <caszonyi@yahoo.com>, Dave Jones <davej@redhat.com>,
       torvalds@osdl.org, jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1110325851.6510.23.camel@mindpipe>
References: <20050308232552.97747.qmail@web52907.mail.yahoo.com>
	 <1110325851.6510.23.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110391396.28860.211.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 18:03:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-08 at 23:50, Lee Revell wrote:
> This only works because those OS'es come bundled with a toy softsynth.
> With ALSA, you either need a supported hardware wavetable synth
> (emu10k1) or a real soft synth like Timidity or Fluidsynth.

CS4239 has a toy synth of sorts (its more "doorbell" than synth
admittedly). There are a pile of funnies with IBM laptops and CS423x to
watch out for that might be worth mentioning - in particular you need to
turn the fast boot stuff -off-.

