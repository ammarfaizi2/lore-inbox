Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVHRS4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVHRS4Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVHRS4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:56:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:51416 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932288AbVHRS4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:56:24 -0400
Date: Thu, 18 Aug 2005 11:54:01 -0700
From: Greg KH <greg@kroah.com>
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       lm-sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 0/5] improve i2c probing
Message-ID: <20050818185401.GA32684@kroah.com>
References: <20050815175106.GA24959@litech.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815175106.GA24959@litech.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 01:51:06PM -0400, Nathan Lutchansky wrote:
> Hi everyone,
> 
> This patch series makes a couple of improvements to the i2c device
> probing process.

<snip>

These all generally look quite good, thanks.  But it looks like you and
Jean went back and forth on a few issues, care to repost an updated
series of patches based on that exchange so I can have them get some
testing in the -mm tree?

thanks,

greg k-h
