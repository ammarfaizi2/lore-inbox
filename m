Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTIYXBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbTIYXBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:01:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:57005 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261670AbTIYXBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:01:36 -0400
Date: Thu, 25 Sep 2003 15:22:30 -0700
From: Greg KH <greg@kroah.com>
To: Martin Kacer <M.Kacer@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with USB/VISOR module
Message-ID: <20030925222229.GA30186@kroah.com>
References: <Pine.LNX.4.58.0309251218460.24867@duck.sh.cvut.cz> <20030925211434.GC29680@kroah.com> <Pine.LNX.4.58.0309260002140.26074@duck.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0309260002140.26074@duck.sh.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 12:05:19AM +0200, Martin Kacer wrote:
> On Thu, 25 Sep 2003, Greg KH wrote:
> # Why are you trying to attach to port 0?  What happens with:
> # 	pilot-xfer -p /dev/ttyUSB1 -l
> 
>    The same thing. I've already tried that before.

Well it looks like the kernel driver is working just fine.  I sugest
taking this to the pilot-link mailing lists.

Good luck,

greg k-h
