Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTEMVUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTEMVUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:20:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60143 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263428AbTEMVUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:20:18 -0400
Date: Tue, 13 May 2003 13:51:32 -0700
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Cc: mhoffman@lightlink.com
Subject: Re: [PATCH] Add SiS96x I2C/SMBus driver (vs 2.5.69-bk6)
Message-ID: <20030513205132.GA11843@kroah.com>
References: <20030512010613.GA12130@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512010613.GA12130@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 09:06:13PM -0400, Mark M. Hoffman wrote:
> This patch adds support for the SMBus of SiS96x south
> bridges.  It is based on i2c-sis645.c from the lm sensors
> project, which never made it into an official kernel and
> was anyway mis-named.
> 
> This driver works on my SiS 645/961 board vs w83781d.

Thanks, I've applied this to my trees and will send it on.

greg k-h
