Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbTIIW6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbTIIW4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:56:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:25823 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265002AbTIIWxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:53:48 -0400
Date: Tue, 9 Sep 2003 15:51:25 -0700
From: Greg KH <greg@kroah.com>
To: Remo Inverardi <invi@your.toilet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI Host Controler Died
Message-ID: <20030909225125.GA7995@kroah.com>
References: <3F5E4D93.9030804@your.toilet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5E4D93.9030804@your.toilet.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 12:00:51AM +0200, Remo Inverardi wrote:
> By the way, if I insert the token when VMware is *not* running,
> /proc/bus/usb shows that the token was detected correctly:

Great, go bug vmware then :)

I didn't think their product was supposed to be working on 2.6 yet
anyway...

thanks,

greg k-h
