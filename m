Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263587AbVCECWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbVCECWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbVCEB7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:59:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25744 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263332AbVCEBht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:37:49 -0500
Message-ID: <42290D58.6090908@pobox.com>
Date: Fri, 04 Mar 2005 20:37:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050304143614.203278fd.akpm@osdl.org> <20050305000604.GA3355@kroah.com>
In-Reply-To: <20050305000604.GA3355@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Mar 04, 2005 at 02:36:14PM -0800, Andrew Morton wrote:
> 
>>But we end up with a cset in the permanent kernel history which simply
>>should not have been there.
> 
> 
> Is this really a big deal?

If you are pushing linux-release to Linus/Andrew rapidly, quick fixes 
will land in linux-2.6 rapidly, and more invasive stuff will land only 
in linux-2.6 when the invasive stuff is ready to go.  It even takes the 
pressure off pushing invasive stuff ASAP.

Have you pushed linux-2.6.11.1 upstream yet?  :)

	Jeff



