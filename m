Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWHIPxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWHIPxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWHIPxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:53:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56030 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751077AbWHIPxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:53:11 -0400
Subject: Re: [Alsa-user] another in kernel alsa update that breaks backward
	compatibilty?
From: Lee Revell <rlrevell@joe-job.com>
To: Sergei Steshenko <steshenko_sergei@list.ru>
Cc: Gene Heskett <gene.heskett@verizon.net>, alsa-user@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060809184658.2bdfb169@comp.home.net>
References: <200608091140.02777.gene.heskett@verizon.net>
	 <20060809184658.2bdfb169@comp.home.net>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 11:53:09 -0400
Message-Id: <1155138789.26338.170.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 18:46 +0300, Sergei Steshenko wrote:
> On Wed, 09 Aug 2006 11:40:02 -0400
> Gene Heskett <gene.heskett@verizon.net> wrote:
> 
> > Greetings;
> > 
> > The old fart is back again. :)
> > 
> > I've just done a divide and conquer on kernel versions, and have found that 
> > while I DO have a kde audio signon for kernels 2.6.18-rc1-rc3-rc4, I do 
> > not have any other functioning audio, including the kde sound effects I 
> > normally get.  xmms and tvtime are mute, as are the firefox plugins to 
> > play videos from the network. 2.6.17.8 and below works great yet.
> > 
> > So whats the fix?
> > 
> 
> 
> Demand stable ABI.
> 

Stable ABI has nothing to do with this, it's called "a bug".

Lee

