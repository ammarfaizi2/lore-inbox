Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbVHTALn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbVHTALn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVHTALn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:11:43 -0400
Received: from kent.litech.org ([72.9.242.215]:50699 "EHLO kent.litech.org")
	by vger.kernel.org with ESMTP id S965202AbVHTALj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:11:39 -0400
Date: Fri, 19 Aug 2005 20:11:35 -0400 (EDT)
From: Nathan Lutchansky <lutchann@litech.org>
To: Greg KH <greg@kroah.com>
cc: LKML <linux-kernel@vger.kernel.org>,
       lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 0/5] improve i2c probing
In-Reply-To: <20050818185401.GA32684@kroah.com>
Message-ID: <Pine.LNX.4.58.0508192010390.31004@puck.litech.org>
References: <20050815175106.GA24959@litech.org> <20050818185401.GA32684@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Greg KH wrote:
> On Mon, Aug 15, 2005 at 01:51:06PM -0400, Nathan Lutchansky wrote:
> > This patch series makes a couple of improvements to the i2c device
> > probing process.
> 
> <snip>
> 
> These all generally look quite good, thanks.  But it looks like you and
> Jean went back and forth on a few issues, care to repost an updated
> series of patches based on that exchange so I can have them get some
> testing in the -mm tree?

Yup, I'm going to break the series into two parts and post the first one 
probably tomorrow.  I haven't been in a hurry since Jean's been away this 
week.  -Nathan
