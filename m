Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSGRGEI>; Thu, 18 Jul 2002 02:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317976AbSGRGEI>; Thu, 18 Jul 2002 02:04:08 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:2821 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316845AbSGRGEH>;
	Thu, 18 Jul 2002 02:04:07 -0400
Date: Wed, 17 Jul 2002 23:05:52 -0700
From: Greg KH <greg@kroah.com>
To: Pierre ROUSSELET <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.25  uhci-hcd  very bad
Message-ID: <20020718060551.GB12626@kroah.com>
References: <3D308A30.7070702@wanadoo.fr> <20020717213332.GA10227@kroah.com> <3D2A7916004B5024@mel-rta10.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2A7916004B5024@mel-rta10.wanadoo.fr>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 20 Jun 2002 05:03:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 08:35:37AM +0200, Pierre ROUSSELET wrote:
> The driver is made of a kernel module speedtch.o (built outside of the
> tree) and of userspace modem firmware loader and management daemon
> speedmgt.

I'd suggest asking the authors of the driver about this.

Good luck,

greg k-h
