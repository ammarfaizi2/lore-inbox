Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWGAXOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWGAXOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWGAXOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:14:00 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:47291 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750735AbWGAXN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:13:59 -0400
Date: Sat, 1 Jul 2006 09:31:33 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
       Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
Message-ID: <20060701073133.GA99126@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Lee Revell <rlrevell@joe-job.com>,
	James Courtier-Dutton <James@superbug.co.uk>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	perex@suse.cz, Olaf Hering <olh@suse.de>
References: <20060629192128.GE19712@stusta.de> <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org> <1151702966.32444.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151702966.32444.57.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
> Even if you reject this argument, the bug is in ALSA's in-kernel OSS
> emulation, not the emu10k1 driver.

That's irrelevant.  You can't remove the oss emu10k1 driver in favor
of alsa's until alsa provides an equivalent interface.  That's a basic
compatibility requirement.


> ALSA's in-kernel OSS emulation does not have these features and
> never will.

"Never" is terribly long.

  OG.
