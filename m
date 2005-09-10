Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVIJXbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVIJXbb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVIJXbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:31:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:63148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932377AbVIJXba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:31:30 -0400
Date: Sat, 10 Sep 2005 16:30:56 -0700
From: Greg KH <gregkh@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050910233056.GA17892@suse.de>
References: <20050909214542.GA29200@kroah.com> <1126394652l.6738l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126394652l.6738l.0l@werewolf.able.es>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 11:24:12PM +0000, J.A. Magallon wrote:
> 
> On 09.09, Greg KH wrote:
> > Here are the same "delete devfs" patches that I submitted for 2.6.12.
> 
> Would this be accompained with deleting all the devfs compat scripts in
> udev (for 069) ? ;)

That is only 1 file, which starts out with the following statement:
	# The use of these rules is not recommended or supported.

how much more obvious do you want us udev developers to make it?  :)

thanks,

greg k-h
