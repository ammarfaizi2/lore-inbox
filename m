Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129963AbRBAMmI>; Thu, 1 Feb 2001 07:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbRBAMl7>; Thu, 1 Feb 2001 07:41:59 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58339 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129983AbRBAMls>;
	Thu, 1 Feb 2001 07:41:48 -0500
Date: Thu, 1 Feb 2001 12:39:20 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: bsuparna@in.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201123920.N11607@redhat.com>
In-Reply-To: <CA2569E6.002C643A.00@d73mta03.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CA2569E6.002C643A.00@d73mta03.au.ibm.com>; from bsuparna@in.ibm.com on Thu, Feb 01, 2001 at 01:28:33PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 01:28:33PM +0530, bsuparna@in.ibm.com wrote:
> 
> Here's a second pass attempt, based on Ben's wait queue extensions:
> Does this sound any better ?

It's a mechanism, all right, but you haven't described what problems
it is trying to solve, and where it is likely to be used, so it's hard
to judge it. :)

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
