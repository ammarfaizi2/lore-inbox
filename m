Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWFITp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWFITp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWFITp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:45:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33694 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030461AbWFITpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:45:25 -0400
Message-ID: <4489CFCC.40209@garzik.org>
Date: Fri, 09 Jun 2006 15:45:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Matthew Frost <artusemrys@sbcglobal.net>, Alex Tomas <alex@clusterfs.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1FompD-0006pL-Dg@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1FompD-0006pL-Dg@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:
> On Fri, 09 Jun 2006 14:51:55 EDT, Jeff Garzik wrote:
>> PRECISELY.  So you should stop modifying a filesystem whose design is 
>> admittedly _not_ modern!
> 
> So just how long do you think it would take to get a modern filesystem
> into the hands of real users, supported by the distros?  From community
> building, through design, development, testing, delivery?

Start from a known working point, and keep it working...

	Jeff



