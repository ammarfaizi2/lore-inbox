Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVKDRHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVKDRHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKDRHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:07:04 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:32474 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750734AbVKDRHC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:07:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j25zTKpLCnMzeY+MtBw80QovAqMNUUmgZJLUELS5pZnra0TkcCw88JI0r6fIzhoudQJlQfE/zSpOGw1urcHnswopxmrNFpQjPamzRd7eRZkBVllos7JdoZVJBJxzurQeqCM9dL0oWPAxHdJr/mjvc/zoHAbj2FGVorRZ+Ajbyqs=
Message-ID: <afcef88a0511040907ueba985dwe0994f3e78717b08@mail.gmail.com>
Date: Fri, 4 Nov 2005 11:07:01 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/12: eCryptfs] Makefile and Kconfig
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <20051104163555.GA13420@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103034207.GA3005@sshock.rn.byu.edu>
	 <afcef88a0511030721g68ddf71bjf02397abcd8da30@mail.gmail.com>
	 <20051103230551.GB30487@kroah.com>
	 <afcef88a0511040809p4e9cf962me25c037cbfb9e967@mail.gmail.com>
	 <20051104163555.GA13420@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 04, 2005 at 10:09:43AM -0600, Michael Thompson wrote:
> > On 11/3/05, Greg KH <greg@kroah.com> wrote:
> > > On Thu, Nov 03, 2005 at 09:21:16AM -0600, Michael Thompson wrote:
> > > > On 11/2/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > > > > These patches modify fs/Makefile and fs/Kconfig to provide build
> > > > > support for eCryptfs.
> > > > >
> > > > > Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
> > > > > Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
> > > > > Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
> > > >
> > > > That should read:
> > > > Signed off by: Michael Thompson <mcthomps@us.ibm.com>
> > >
> > > No, that's not how it is documented on how to do this.  Please try
> > > again.
> >
> > I've just rummaged around in linux/Documentation and I have not been
> > able to find, either in a specific file, or by looking at "The Perfect
> > Patch", or other related links, on how to fix an incorrect
> > "Signed-off-by" line.
>
> You do not have the "-"s in the statements above, that is what I was
> referring to.
>
> thanks,
>
> greg k-h
>

You can surely see how I was confused, seeing that you replied to my
updated and flawed "Signed off by" amendment, stating it was
incorrect, while the original posting contained exactly the same
error. However, now that I know what you were talking about, all
things become clear.

I'll be sure not to make this mistake again, if just for confusion's sake.

Mike

--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
