Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUANRYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUANRYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:24:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:56269 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262055AbUANRYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:24:24 -0500
Date: Wed, 14 Jan 2004 09:12:48 -0800
From: Greg KH <greg@kroah.com>
To: Sean Hunter <sean@uncarved.com>, linux-kernel@vger.kernel.org
Subject: Re: Soekris/udev 2.6 success story
Message-ID: <20040114171248.GA5472@kroah.com>
References: <20040114164411.GA13847@uncarved.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114164411.GA13847@uncarved.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 04:44:11PM +0000, Sean Hunter wrote:
> 2.6 has been working great on my soekris net4801 (see
> http://www.soekris.com/net4801.htm) dns server/firewall and since it
> uses a compact flash card for root, I implemented /dev on tmpfs using
> udev, and it all works using the sysfs patches in the mm series kernels.

Great, glad to hear it's working for you.

greg k-h
