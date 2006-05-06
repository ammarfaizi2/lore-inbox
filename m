Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWEFPTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWEFPTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 11:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWEFPTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 11:19:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:41612 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750856AbWEFPTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 11:19:11 -0400
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network
	drivers
From: Lee Revell <rlrevell@joe-job.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: "David S. Miller" <davem@davemloft.net>, mpm@selenic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060506140850.GN25646@vanheusden.com>
References: <2.420169009@selenic.com> <8.420169009@selenic.com>
	 <20060505.141040.53473194.davem@davemloft.net>
	 <20060506140850.GN25646@vanheusden.com>
Content-Type: text/plain
Date: Sat, 06 May 2006 11:19:03 -0400
Message-Id: <1146928743.15364.89.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-06 at 16:08 +0200, Folkert van Heusden wrote:
> Consider adding a cheap soundcard to the system and run
> 'audio-entropyd': www.vanheusden.com/aed 

Can't get much cheaper than the crap that comes on every motherboard
these days ;-)

Also aren't temp sensors (on the disk or mobo) a good entropy source?

Lee

