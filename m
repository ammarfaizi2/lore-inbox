Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbUBXTop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUBXToo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:44:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:18641 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262415AbUBXTom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:44:42 -0500
Date: Tue, 24 Feb 2004 11:44:30 -0800
From: Greg KH <greg@kroah.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: linux-kernel@vger.kernel.org, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040224194430.GB639@kroah.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C36C7@orsmsx410.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C36C7@orsmsx410.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 11:29:04AM -0800, Woodruff, Robert J wrote:
> 
> Since it is rather big,
> I have posted a patch for the InfiniBand Access Layer (IBAL) 
> for the linux-2.6.3 kernel on sourceforge in the file releases
> area. 
> http://sourceforge.net/projects/infiniband

The
http://osdn.dl.sourceforge.net/sourceforge/infiniband/patch-2_6_3-iba.bz2
patch is corrupted.

> We have already received some comments from Greg and others(such as 
> not liking the Component library (Complib) abstraction layer)
> and we are starting to make those changes. Greg suggested that
> we submit the code to the larger Linux community for review, 
> so here it is. 

Please make those changes and then post the patch here (not just a link,
if it's too big, split it up into the logical pieces to fit.)  We can go
from there.

thanks,

greg k-h
