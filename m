Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbRGITxg>; Mon, 9 Jul 2001 15:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264869AbRGITx0>; Mon, 9 Jul 2001 15:53:26 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:9998 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S264860AbRGITxQ>;
	Mon, 9 Jul 2001 15:53:16 -0400
Date: Mon, 9 Jul 2001 13:53:16 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010709135316.A9731@qcc.sk.ca>
In-Reply-To: <15177.65286.592796.329570@charged.uio.no> <Pine.LNX.3.96L.1010709153516.16113R-100000@happyplace.pdl.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96L.1010709153516.16113R-100000@happyplace.pdl.cmu.edu>; from soules@happyplace.pdl.cmu.edu on Mon, Jul 09, 2001 at 03:45:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Soules <soules@happyplace.pdl.cmu.edu> wrote:
> 
> Ok, perhaps I mis-spoke slightly.  What the spec does state is that the
> cookie is opaque.  This has generally been interpreted to mean that you
> should not trust it to be stable after a change to that directory.

I thought the generally accepted meaning of "opaque" in this context was
"don't expect to be able to infer anything relevant from this data".  This has
nothing to do with how long a particular cookie is valid.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
