Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTKVQuX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 11:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTKVQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 11:50:23 -0500
Received: from mail.kroah.org ([65.200.24.183]:63957 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262375AbTKVQuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 11:50:19 -0500
Date: Sat, 22 Nov 2003 08:49:07 -0800
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Marcelo Tosatti <marcelo@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH 2.4] Trivial changes to I2C stuff
Message-ID: <20031122164907.GA3121@kroah.com>
References: <20031122161510.7d5b4d20.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031122161510.7d5b4d20.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 04:15:10PM +0100, Jean Delvare wrote:
> Hi Marcelo, hi list,
> 
> Below is a simple patch that does some trivial changes to a few i2c
> drivers in 2.4.23-rc3. The changes are only white space and comment
> changes, and line reordering. There are also two simple changes to
> i2c-id.h to keep it in line with the one in Linux 2.6.0-test9.

Woah, -rc3 is _way_ too late for patches such as this.  Please wait for
2.4.23 to come out first.

thanks,

greg k-h
