Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVLCWe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVLCWe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVLCWeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:34:25 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:39870 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932131AbVLCWeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:34:25 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203222731.GC25722@merlin.emma.line.org>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
	 <4391CEC7.30905@unsolicited.net>
	 <1133630012.6724.7.camel@localhost.localdomain>
	 <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
	 <4391E52D.6020702@unsolicited.net>
	 <20051203222731.GC25722@merlin.emma.line.org>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 17:34:20 -0500
Message-Id: <1133649261.5890.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 23:27 +0100, Matthias Andree wrote:
> A kernel that calls itself stable CAN NOT remove
> features unless they had been critically broken from the beginning. 

So in your opinion we can't add support for new hardware to a stable
kernel either because there's a chance of breaking something that worked
before, which brings us right back to "stable" meaning "no progress
allowed", which begs the question of why you want to upgrade at all.

Lee

