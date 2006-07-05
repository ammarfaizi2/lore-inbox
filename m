Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWGEVmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWGEVmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWGEVmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:42:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50394 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965044AbWGEVmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:42:38 -0400
Subject: Re: OSS driver removal, 2nd round
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, Bill Davidsen <davidsen@tmr.com>,
       =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez?= <ismail@pardus.org.tr>,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Olaf Hering <olh@suse.de>, James Courtier-Dutton <James@superbug.co.uk>,
       perex@suse.cz
In-Reply-To: <1152128058.15837.130.camel@mindpipe>
References: <20060629192128.GE19712@stusta.de>
	 <200607010042.15765.ismail@pardus.org.tr>
	 <1151704572.32444.74.camel@mindpipe>
	 <200607010249.05140.ismail@pardus.org.tr> <44A99C72.7070602@tmr.com>
	 <44AB69FA.4090305@stesmi.com>  <1152128058.15837.130.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Jul 2006 22:56:51 +0100
Message-Id: <1152136611.6533.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-05 am 15:34 -0400, ysgrifennodd Lee Revell:
> > v4l != alsa. :) 
> 
> A user visible API is being removed in 2.6.18?  Really?
> 
> I thought the rule was that 2.6 is a stable series therefore no
> user-visible API changes were allowed.

V4L2 has a translation layer

