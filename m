Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbRAEXtp>; Fri, 5 Jan 2001 18:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRAEXtf>; Fri, 5 Jan 2001 18:49:35 -0500
Received: from adsl-63-194-89-126.dsl.snfc21.pacbell.net ([63.194.89.126]:51218
	"HELO skull.piratehaven.org") by vger.kernel.org with SMTP
	id <S130664AbRAEXtY>; Fri, 5 Jan 2001 18:49:24 -0500
Date: Fri, 5 Jan 2001 15:44:46 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: InfiniBand Project
Message-ID: <20010105154446.A11669@skull.piratehaven.org>
Mail-Followup-To: yiding_wang@agilent.com, linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797101128D68@xsj02.sjs.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797101128D68@xsj02.sjs.agilent.com>
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possibility I could work on here at LLNL.  My group has
been talking about investigating Infiniband and we figured Linux would
be a good spot to start with it.  The ASCI Purple machine (100 TFLOPS)
will probably use IB for it's I/O network, though there is obviously
no commitment to is yet as this machines delivery date is a ways away.
We need to start looking at it soon so we know how well we can
integrate it into our environment.


BAPper

On Fri, Jan 05, 2001 at 04:06:24PM -0700, yiding_wang@agilent.com wrote:
> Has anyone started IB support project for Linux yet?  Particularly I am
> interested in OS support and verbs layer from Linux side.  I am involved in
> an IB product on HCA and TCA side.  Current solution will be emulating scsi
> but eventually all IB component is required.  I noticed that kernel 2.4.0
> only has IB class defined.
> 
> Many thanks!
> 
> Eddie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
