Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423020AbWBBGjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423020AbWBBGjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423028AbWBBGjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:39:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:17365 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423020AbWBBGjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:39:08 -0500
From: Andi Kleen <ak@suse.de>
To: "shin, jacob" <jacob.shin@amd.com>
Subject: Re: powernow-k8: out of sync on Athlon64 x2 3800+
Date: Thu, 2 Feb 2006 07:37:34 +0100
User-Agent: KMail/1.8
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org,
       "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       "Niklas Edmundsson" <Niklas.Edmundsson@hpc2n.umu.se>,
       Andreas.Burghart@fujitsu-siemens.com
References: <B3870AD84389624BAF87A3C7B83149930293551F@SAUSEXMB2.amd.com>
In-Reply-To: <B3870AD84389624BAF87A3C7B83149930293551F@SAUSEXMB2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602020737.34781.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 01:05, shin, jacob wrote:

> I was wondering if anyone has already tested Andi's patch, if it
> successfully solves this problem, and if the patch has made it into the git
> yet.

It's in 2.6.16-rc1. If you think it's critical I can propose it for 2.6.15 
stable too.

-Andi
