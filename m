Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSKDXJa>; Mon, 4 Nov 2002 18:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbSKDXJa>; Mon, 4 Nov 2002 18:09:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27657 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262881AbSKDXJ3>;
	Mon, 4 Nov 2002 18:09:29 -0500
Message-ID: <3DC6FF60.2000100@pobox.com>
Date: Mon, 04 Nov 2002 18:14:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC: A POSIX Linux project?
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if any vendors, or independent groups, would be interested in 
maintaining a POSIX compliancy patchkit for the Linux kernel?

IMO such a "POSIX Linux" project would be useful for several reasons. 
 Overall, I think there is pressure from several directions to get all 
sorts of POSIX APIs into the kernel.  On occasion, kernel hackers are 
confronted with a situation where complete POSIX compliancy may mean a 
compromise in some area, be it performance, security, API issues, code 
cleanliness issues, etc.  Or simply that the POSIX-related code just 
isn't ready to be merged into the mainline kernel yet.

The vendors also benefit by this, because the barrier to entry in 
POSIX-related cases would be lowered, which would in turn satisfy the 
demands of customers.  Which would in turn give the mainline kernel all 
the software engineering benefits that come from a more reasoned and 
gradual review and merge of new features.

Does something like this already exist?  This would need to be an open, 
vendor-neutral project...

    Jeff




