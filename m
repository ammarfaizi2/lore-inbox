Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVDOVEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVDOVEi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVDOVEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:04:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:60310 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261972AbVDOVEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:04:33 -0400
Date: Fri, 15 Apr 2005 14:04:02 -0700
From: Greg KH <greg@kroah.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Kylene Hall <kjhall@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/tpm: use msleep(), clean-up timers, fix typo
Message-ID: <20050415210402.GA22834@kroah.com>
References: <20050310004115.GA32583@kroah.com> <1110415321526@kroah.com> <20050311181816.GC2595@us.ibm.com> <Pine.LNX.4.61.0504151522210.24192@dyn95395164> <29495f1d0504151344a33ee24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0504151344a33ee24@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 01:44:55PM -0700, Nish Aravamudan wrote:
> On 4/15/05, Kylene Hall <kjhall@us.ibm.com> wrote:
> > I have tested this patch and agree that using msleep is the right.  Please
> > apply this patch to the tpm driver.  One hunk might fail b/c the
> > typo has been fixed already.
> 
> Would you like me to respin the patch, Greg? Or is the failed hunk ok?

I'm sorry, but I am not in charge of accepting patches for the tpm
driver.  Why not go through the listed maintainer for this process, they
should know how to get it into the mainline kernel tree properly.  If
not, why would they be listed as the maintainer?  :)

thanks,

greg k-h
