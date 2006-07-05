Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWGETdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWGETdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWGETdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:33:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31669 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965001AbWGETdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:33:44 -0400
Subject: Re: OSS driver removal, 2nd round
From: Lee Revell <rlrevell@joe-job.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       =?iso-8859-9?Q?=DDsmail_D=F6nmez?= <ismail@pardus.org.tr>,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>,
       James Courtier-Dutton <James@superbug.co.uk>, perex@suse.cz
In-Reply-To: <44AB69FA.4090305@stesmi.com>
References: <20060629192128.GE19712@stusta.de>
	 <200607010042.15765.ismail@pardus.org.tr>
	 <1151704572.32444.74.camel@mindpipe>
	 <200607010249.05140.ismail@pardus.org.tr> <44A99C72.7070602@tmr.com>
	 <44AB69FA.4090305@stesmi.com>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 15:34:17 -0400
Message-Id: <1152128058.15837.130.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 09:27 +0200, Stefan Smietanowski wrote:
> It's being written for v4l v1 api which is being phased out with
> 2.6.18.
> 
> They already have alsa working (and from the sound of it it's working
> great!).
> 
> v4l != alsa. :) 

A user visible API is being removed in 2.6.18?  Really?

I thought the rule was that 2.6 is a stable series therefore no
user-visible API changes were allowed.

Lee

