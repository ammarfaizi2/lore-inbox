Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVCQI2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVCQI2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 03:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVCQI2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 03:28:04 -0500
Received: from host.almesberger.net ([204.10.140.10]:42252 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261892AbVCQI2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 03:28:02 -0500
Date: Thu, 17 Mar 2005 05:26:11 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] yaird, a mkinitrd based on hotplug concepts
Message-ID: <20050317052611.A17469@almesberger.net>
References: <20050217210620.A20645@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217210620.A20645@banaan.localdomain>; from ekonijn@xs4all.nl on Thu, Feb 17, 2005 at 09:06:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik van Konijnenburg wrote:
> Yaird is intended to find out whether that assumption is correct: if so, 
> a program to build initrd images will be more reliable if it's written
> in perl, if it uses sysfs to determine what hardware needs to be supported,
> and if it closely follows the methods hotplug uses find the modules
> needed to support some hardware.

This is great, and was long overdue. Thanks for fixing my sins of
omission dating back from 1996 :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
