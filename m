Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbTLISVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266044AbTLISVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:21:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:40368 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266038AbTLISVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:21:50 -0500
Date: Tue, 9 Dec 2003 10:20:46 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <rob@landley.net>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209182046.GB9461@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <200312082326.17723.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312082326.17723.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 11:26:17PM -0600, Rob Landley wrote:
> Is there a big rollup patch against that adds all the sys/*/dev entries for 
> people who want to try udev?

Oh, and you can try udev today with no kernel patches needed.  All block
devices and tty devices and i2c dev devices and usb major devices and
v4l devices work just fine with udev on 2.6.0-test11.

thanks,

greg k-h
