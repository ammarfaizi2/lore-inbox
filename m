Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTKVSJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 13:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTKVSJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 13:09:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:40940 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262569AbTKVSJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 13:09:34 -0500
Date: Sat, 22 Nov 2003 10:08:18 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com
Cc: marcelo@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] Trivial changes to I2C stuff
Message-ID: <20031122180818.GA3378@kroah.com>
References: <20031122161510.7d5b4d20.khali@linux-fr.org> <20031122164907.GA3121@kroah.com> <20031122183617.18149a3d.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031122183617.18149a3d.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 06:36:17PM +0100, Jean Delvare wrote:
> > Woah, -rc3 is _way_ too late for patches such as this.
> 
> "Patches like this"? A patch could hardly do less (real) things than
> this one. What's the problem? I thought -rc were a perfect place for
> these kind of cleanup changes.

Only _critical_ fixes are allowed during the -rc cycle.  These are stuff
like bugfixes, not whitespace cleanups.

thanks,

greg k-h
