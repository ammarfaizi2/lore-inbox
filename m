Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWHRSkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWHRSkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWHRSkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:40:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29876 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750843AbWHRSkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:40:07 -0400
Subject: Re: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060818183609.GE21101@flint.arm.linux.org.uk>
References: <1155862076.24907.5.camel@mindpipe>
	 <1155915851.3426.4.camel@amdx2.microgate.com>
	 <1155923734.2924.16.camel@mindpipe> <44E602C8.3030805@microgate.com>
	 <1155925024.2924.22.camel@mindpipe>
	 <20060818183609.GE21101@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 14:40:05 -0400
Message-Id: <1155926405.2924.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 19:36 +0100, Russell King wrote:
> On Fri, Aug 18, 2006 at 02:17:04PM -0400, Lee Revell wrote:
> Are you transferring from or two the machine which is having a problem?
> IOW, is the problem machine doing lots of receive or lots of transmit?
> 

Neither uploads nor downloads work in interrupt mode.  Both work in
polled mode.

Lee

