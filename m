Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUBXSSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbUBXSRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:17:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:25773 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262380AbUBXSQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:16:46 -0500
Date: Tue, 24 Feb 2004 10:03:04 -0800
From: Greg KH <greg@kroah.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>,
       "Tillier, Fabian" <ftillier@infiniconsys.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       hozer@hozed.org, "Woodruff, Robert J" <woody@jf.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040224180304.GA31826@kroah.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C36C4@orsmsx410.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C36C4@orsmsx410.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 09:55:25AM -0800, Woodruff, Robert J wrote:
> 
> Would you like me to submit the patch directly to linux-kernel email
> list ? 

Yes, please do.  If you want, feel free to cc: me also.

But as you have not cleaned up the stuff that everyone has already told
you to clean up, it might be pretty pointless to do so without fixing
that code first.  In fact, why even post a patch without making those,
necessary changes?

thanks,

greg k-h
