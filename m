Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTIZTZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 15:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTIZTZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 15:25:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:43232 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261598AbTIZTZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 15:25:15 -0400
Date: Fri, 26 Sep 2003 12:10:58 -0700
From: Greg KH <greg@kroah.com>
To: Martin Kacer <M.Kacer@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with USB/VISOR module
Message-ID: <20030926191058.GA17836@kroah.com>
References: <Pine.LNX.4.58.0309251218460.24867@duck.sh.cvut.cz> <20030925211434.GC29680@kroah.com> <Pine.LNX.4.58.0309260002140.26074@duck.sh.cvut.cz> <20030925222229.GA30186@kroah.com> <Pine.LNX.4.58.0309260944480.26794@duck.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0309260944480.26794@duck.sh.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 09:49:56AM +0200, Martin Kacer wrote:
> On Thu, 25 Sep 2003, Greg KH wrote:
> # Well it looks like the kernel driver is working just fine.  I sugest
> # taking this to the pilot-link mailing lists.
> 
> Greg,
> 
> I do not think it is a pilot-link's fault when the functionality breaks
> with a new hardware. The kernel is to provide transparent behavior for
> any HW, isn't it?

Do any other USB devices work on this machine?

greg k-h
