Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUCZWcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUCZWcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:32:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:33732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261380AbUCZWcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:32:50 -0500
Date: Fri, 26 Mar 2004 14:32:04 -0800
From: Greg KH <greg@kroah.com>
To: Linda Xie <lxiep@linux.ibm.com.kroah.org>
Cc: Linus Torvalds <torvalds@osdl.org>, John Rose <johnrose@austin.ibm.com>,
       gregkh@us.ibm.com, Wortman/Austin/IBM@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: PATCH -- kobject_set_name() doesn't allocate enough space]
Message-ID: <20040326223204.GA30729@kroah.com>
References: <40649B96.7010503@ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40649B96.7010503@ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 03:07:34PM -0600, Linda Xie wrote:
> Hi Linus,
> 
> 
> Please see attached patch at the end of FW mail and apply it to your tree.

Your patch is munged again and will not apply :(

Can you send me a new version?  I'll apply it to my tree and let it get
tested in the -mm tree before sending it on to Linus.

thanks,

greg k-h
