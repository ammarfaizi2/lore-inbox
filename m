Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbVH2UVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbVH2UVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVH2UVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:21:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5028 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751596AbVH2UVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:21:13 -0400
Subject: Re: 2.6.13 new option timer frequency
From: Lee Revell <rlrevell@joe-job.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050829184818.3305.qmail@lwn.net>
References: <20050829184818.3305.qmail@lwn.net>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 16:21:10 -0400
Message-Id: <1125346871.4598.71.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 12:48 -0600, Jonathan Corbet wrote:
> > I built and installed 2.6.13 today, and oldconfig revealed the new option for 
> > timer frequency.
> > 
> > I searched the LKML on this, but all I found is the technical stuff - not 
> > really any layman solutions.
> 
> I wrote a bit about the timer frequency option a few weeks ago:
> 
> 	http://lwn.net/Articles/145973/
> 

I just updated the thread to explain the "singing capacitor" issue which
has been mostly overlooked in this debate so far.

Lee

