Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbUBXVBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUBXVBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:01:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:2703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262449AbUBXVBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:01:22 -0500
Date: Tue, 24 Feb 2004 13:01:21 -0800
From: Greg KH <greg@kroah.com>
To: Elmer Joandi <elmer@linking.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple Centrino-laptop unknown devices, new IDS, USB nonworking
Message-ID: <20040224210121.GA1381@kroah.com>
References: <1077638587.3660.23.camel@localhost.localdomain> <20040224184442.GA32383@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224184442.GA32383@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 10:44:43AM -0800, Greg KH wrote:
> On Tue, Feb 24, 2004 at 06:03:08PM +0200, Elmer Joandi wrote:
> > 9. Havent tried sensors, sensors-detect(Fedore core+ updates) can not
> > 	find /proc/bus/i2c, i2c-dev is loaded.
> 
> You need a newer userspace lmsensors to work with 2.6.  There is no
> i2c-dev anymore.

Sorry, I mistyped, there is no /proc/bus/i2c anymore.  i2c-dev of course
is still present.

Sorry for any confusion.

greg k-h
