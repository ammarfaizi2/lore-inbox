Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbUBXSwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUBXSwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:52:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:62394 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262403AbUBXSwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:52:09 -0500
Date: Tue, 24 Feb 2004 10:44:43 -0800
From: Greg KH <greg@kroah.com>
To: Elmer Joandi <elmer@linking.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple Centrino-laptop unknown devices, new IDS, USB nonworking
Message-ID: <20040224184442.GA32383@kroah.com>
References: <1077638587.3660.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077638587.3660.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 06:03:08PM +0200, Elmer Joandi wrote:
> 9. Havent tried sensors, sensors-detect(Fedore core+ updates) can not
> 	find /proc/bus/i2c, i2c-dev is loaded.

You need a newer userspace lmsensors to work with 2.6.  There is no
i2c-dev anymore.

Good luck,

greg k-h
