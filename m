Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbTH1S55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264195AbTH1S54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:57:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:52428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264191AbTH1S5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:57:54 -0400
Date: Thu, 28 Aug 2003 11:57:26 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 - where in sysfs?
Message-ID: <20030828185726.GA12328@kroah.com>
References: <E19mVQq-0003st-00.arvidjaar-mail-ru@f7.mail.ru> <20030828091647.GB819@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828091647.GB819@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 11:16:47AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Should character devices appear in sysfs? I cannot see anything
> > resembling the above there. Where does this name come from?
> 
> Input has its own hierarchy. It needs to be modified to work with sysfs.

There has been some patches posted to lkml that do this, but they are
not yet in a stable state.  The person working on them is currently on
vacation so it will be a few weeks before they get finished.

thanks,

greg k-h
