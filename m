Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVKJES3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVKJES3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 23:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbVKJES3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 23:18:29 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18097 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751012AbVKJES2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 23:18:28 -0500
Subject: Re: PROBLEM: b44 network driver performance
From: Lee Revell <rlrevell@joe-job.com>
To: Greg Mitchell <greg.mitchell@emailman.cc>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511080822.03363.greg.mitchell@emailman.cc>
References: <200511080822.03363.greg.mitchell@emailman.cc>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 22:05:36 -0500
Message-Id: <1131591937.8383.137.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 08:22 -0500, Greg Mitchell wrote:
> Summary: Poor performance of b44 driver
> 
> Description: I'm getting a transfer rate of 3 MB/s between two machines on the 
> same 100 Mbit lan. Using Broadcom's bcm4400 driver (which I believe is GPL), 
> I get 10 MB/s.
> 
> Kernel Version: 2.6.13 (vanilla) on a P4

Too old, try 2.6.14.

Lee

