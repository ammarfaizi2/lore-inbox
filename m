Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWIVOAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWIVOAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWIVOAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:00:33 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:5081 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932492AbWIVOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:00:32 -0400
Date: Fri, 22 Sep 2006 10:00:31 -0400
To: Dax Kelson <dax@gurulabs.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20060922140031.GL13639@csclub.uwaterloo.ca>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <1158874809.24172.45.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158874809.24172.45.camel@mentorng.gurulabs.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 03:40:09PM -0600, Dax Kelson wrote:
> Decompression times on 2.6.18 are as follows:
> 
> gzip:   0m3.509s
> 7zip:   0m10.012s
> bzip2:  0m22.703s

Hmm, not bad.

--
Len Sorensen
