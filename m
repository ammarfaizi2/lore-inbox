Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752834AbWKCA50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbWKCA50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbWKCA50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:57:26 -0500
Received: from mail.suse.de ([195.135.220.2]:38558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752834AbWKCA50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:57:26 -0500
Date: Thu, 2 Nov 2006 16:57:28 -0800
From: Greg KH <gregkh@suse.de>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@google.com>,
       Mike Galbraith <efault@gmx.de>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061103005728.GB21821@suse.de>
References: <20061101020850.GA13070@suse.de> <45480241.2090803@google.com> <20061102052409.GA9642@suse.de> <45498174.5070309@google.com> <20061102060225.GA11188@suse.de> <20061101220701.78a1fa88.akpm@osdl.org> <20061102064227.GA11693@suse.de> <20061101224915.19d1b1ac.akpm@osdl.org> <20061102065609.GA14353@suse.de> <20061102112603.38393245@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102112603.38393245@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 11:26:03AM +0100, Cornelia Huck wrote:
> On Wed, 1 Nov 2006 22:56:09 -0800,
> Greg KH <gregkh@suse.de> wrote:
> 
> > Yeah, I knew that would happen.  I have them still in my queue, I'll
> > handle porting them to my tree now, I've forced her to handle my
> > mistakes too much already :)
> 
> Thanks for sorting that out :)
> 
> > Let's verify that this all is fixed first :)
> 
> Seems to work fine for me now.

Thanks for testing this and letting me know.

greg k-h
