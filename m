Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUAaPca (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 10:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUAaPca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 10:32:30 -0500
Received: from mail.kroah.org ([65.200.24.183]:38811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264898AbUAaPc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 10:32:29 -0500
Date: Sat, 31 Jan 2004 07:23:20 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
Message-ID: <20040131152320.GA2730@kroah.com>
References: <10745567662012@kroah.com> <10745567661358@kroah.com> <20040121225012.1addb5c7.khali@linux-fr.org> <20040121235655.GF1958@kroah.com> <20040131095642.09c29ac3.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131095642.09c29ac3.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 09:56:42AM +0100, Jean Delvare wrote:
> > > That said, I still think it was a good idea. Not that it matters
> > > much to me since I don't use that driver, but anyway... Who should I
> > > contact to get it included?
> > 
> > The ieee1394 maintainer?
> 
> OK, done that. It is supposed to have been applied, although it's not in
> 2.6.2-rc3.

Give them time, iee1394 doesn't sync up with Linus as often as USB and
I2C does :)

greg k-h
