Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWCJBa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWCJBa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCJBa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:30:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:49340
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750811AbWCJBa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:30:56 -0500
Date: Thu, 9 Mar 2006 17:30:39 -0800
From: Greg KH <greg@kroah.com>
To: Lanslott Gish <lanslott.gish@gmail.com>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [linux-usb-devel] Re: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Message-ID: <20060310013039.GA26532@kroah.com>
References: <200603082346.37479.daniel.ritz@gmx.ch> <20060309004349.GB1376@kroah.com> <38c09b90603091715u42f79fd5ne8cb62b8f8ddba7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c09b90603091715u42f79fd5ne8cb62b8f8ddba7e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 09:15:28AM +0800, Lanslott Gish wrote:
> Hi,
> 
> merging is the wonderful way. i love all in one :))
> 
> but, every vendor has their own USB Vendor ID.
> How to overcome the issue?

Keep adding them to the device table?  Just like other drivers that
support more than one type of device :)

thanks,

greg k-h
