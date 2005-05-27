Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVE0SHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVE0SHb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVE0SHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:07:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:21694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261952AbVE0SHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:07:20 -0400
Date: Fri, 27 May 2005 11:07:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.11.11
Message-ID: <20050527180711.GH27549@shell0.pdx.osdl.net>
References: <20050527160437.GL23013@shell0.pdx.osdl.net> <1117213882.13829.73.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117213882.13829.73.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2005-05-27 at 09:04 -0700, Chris Wright wrote:
> > Gregor Jasny:
> >   o usbusx2y: prevent oops & dead keyboard on usb unplugging while the device is being used
> >   o usbaudio: prevent oops & dead keyboard on usb unplugging while the device is being used
> 
> Um, Karsten Wiese is the author of this patch.  Someone must have signed
> off on it incorrectly, presumably the person who submitted it for
> -stable.

Yes, you are right, the git commit scripts culled that author info from
the person who submitted it to -stable.
