Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbTAMBvl>; Sun, 12 Jan 2003 20:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTAMBvl>; Sun, 12 Jan 2003 20:51:41 -0500
Received: from holomorphy.com ([66.224.33.161]:41126 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267750AbTAMBvl>;
	Sun, 12 Jan 2003 20:51:41 -0500
Date: Sun, 12 Jan 2003 18:00:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Lang <dlang@diginsite.com>
Cc: Rob Wilkens <robw@optonline.net>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113020018.GC9727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Lang <dlang@diginsite.com>, Rob Wilkens <robw@optonline.net>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> <Pine.LNX.4.44.0301121717140.30519-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301121717140.30519-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 05:26:48PM -0800, David Lang wrote:
> This is becouse not all memory is equal, main memory is very slow compared
> to the CPU cache, so code that is slightly larger can cause more cache
> misses and therefor be slower, even if significantly fewer commands are
> executed.

Not all memory is equal here, either i.e. I'm on NUMA boxen.


Bill
