Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUCLVmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUCLVmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:42:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:40892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262990AbUCLVmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:42:46 -0500
Date: Fri, 12 Mar 2004 13:05:52 -0800
From: Greg KH <greg@kroah.com>
To: backblue <backblue@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a7n8x-x & i2c
Message-ID: <20040312210552.GA1860@kroah.com>
References: <20040310185047.454779fc.backblue@netcabo.pt> <20040312003135.GA26958@kroah.com> <20040312200020.1d92f676.backblue@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312200020.1d92f676.backblue@netcabo.pt>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 08:00:20PM +0000, backblue wrote:
> No i dont have nothing of that enable! all debug options are disable,
> should a7n8x-x work with lm_sensors?

What is "a7n8x-x"?

> sensors-detect says that dont founds any chip's in my machine...

Then I would believe that no sensors are present for it :)

> but it finds nforce2 SMBus.

Hm, did you try the 2.4 package of lmsensors on a 2.4 kernel?  It
supports more chip drivers than 2.6 currently does.

good luck,

greg k-h
