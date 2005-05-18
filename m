Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVERQfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVERQfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVERQfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:35:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:46498 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262281AbVERQf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:35:29 -0400
Date: Wed, 18 May 2005 09:41:22 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2.6.12-rc4 1/15] (dynamic sysfs callbacks) device attribute callbacks - take 2
Message-ID: <20050518164122.GA17307@kroah.com>
References: <2538186705051703394944e949@mail.gmail.com> <20050518072239.GA11889@kroah.com> <253818670505180028696cc991@mail.gmail.com> <20050518073756.GA12382@kroah.com> <2538186705051800412ec07d5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2538186705051800412ec07d5c@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 03:41:59AM -0400, Yani Ioannou wrote:
> BTW I sent a patch against it87.c to lm_sensors so Jean could test
> things (apparently adm1026 hasn't got many users).

Yes, I was going to wait until I got a "ack" from him before applying
that patch.

thanks,

greg k-h
