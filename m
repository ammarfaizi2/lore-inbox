Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129368AbRBARJv>; Thu, 1 Feb 2001 12:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129690AbRBARJl>; Thu, 1 Feb 2001 12:09:41 -0500
Received: from ns.caldera.de ([212.34.180.1]:31238 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129368AbRBARJd>;
	Thu, 1 Feb 2001 12:09:33 -0500
Date: Thu, 1 Feb 2001 18:09:14 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201180914.A29298@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com> <20010201160953.A17058@caldera.de> <20010201161615.T11607@redhat.com> <20010201180515.B28007@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010201180515.B28007@caldera.de>; from hch on Thu, Feb 01, 2001 at 06:05:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 06:05:15PM +0100, Christoph Hellwig wrote:
> > What, you mean adding *extra* stuff to the heavyweight kiobuf makes it
> > lean enough to do the job??
> 
> No.  I was speaking abou the light-weight kiobuf Linux & Me discussed on
						   ^^^^^ Linus ...
> lkml some time ago (though I'd much more like to call it kiovec analogous
> to BSD iovecs).
> 
> And a page,offset,length tuple is pretty cheap compared to a current kiobuf.

	Christoph (slapping himself for the stupid typo and selfreply ...)

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
