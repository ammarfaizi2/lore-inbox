Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269705AbSISAKI>; Wed, 18 Sep 2002 20:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269710AbSISAKI>; Wed, 18 Sep 2002 20:10:08 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:24840 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269705AbSISAKH>;
	Wed, 18 Sep 2002 20:10:07 -0400
Date: Wed, 18 Sep 2002 17:15:09 -0700
From: Greg KH <greg@kroah.com>
To: Michael Duane <Mike.Duane@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDCether.c
Message-ID: <20020919001509.GA12451@kroah.com>
References: <4C568C6A13479744AA1EA3E97EEEB3231B7DDC@schumi.digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C568C6A13479744AA1EA3E97EEEB3231B7DDC@schumi.digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 04:49:52PM -0700, Michael Duane wrote:
> Who is the maintainer of CDCEther.c?  I am having a problem
> with packets getting "wedged" somewhere on the way out
> and need to know if others have reported this problem.

>From the MAINTAINERS file:
	USB CDC ETHERNET DRIVER
	P:      Brad Hards
	M:      bradh@frogmouth.net
	L:      linux-usb-users@lists.sourceforge.net
	L:      linux-usb-devel@lists.sourceforge.net
	S:      Maintained

thanks,

greg k-h
