Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264482AbTCXWzV>; Mon, 24 Mar 2003 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264483AbTCXWzV>; Mon, 24 Mar 2003 17:55:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:41187 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264482AbTCXWzT>;
	Mon, 24 Mar 2003 17:55:19 -0500
Subject: Re: Testing: What do you want?
From: Craig Thomas <craiger@osdl.org>
To: Scott Robert Ladd <coyote@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048525274.25652.3.camel@irongate.swansea.linux.org.uk>
References: <3E7F1A2D.4050306@coyotegulch.com>
	 <1048525274.25652.3.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: OSDL
Message-Id: <1048547186.495.43.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Mar 2003 15:06:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would echo Alan's comments.  Testing on various platforms with
different configurations will show that linux is capable of running
on a larger variety of hardware.

OSDL has a set of stress tests that are run on new kernels as they
become available.  However, the architectures tested are limited
(compared with the variety that can be found in the world).  There 
are enough testers in the community to collectively test for 
correctness of the kernel.  Test suites such as LTP and LSB help
in this regard.

It would be nice to have a collaborative effort of testing and 
reporting of findings so that everyone can look at particular areas
of interest.  There is also need to generate test results quickly so
that defects can be found and corrected in a timely manner if they
exist.
 

On Mon, 2003-03-24 at 09:01, Alan Cox wrote:
> On Mon, 2003-03-24 at 14:46, Scott Robert Ladd wrote:
> > question is: What do the kernel developers want from testers? What sort 
> > of reports are helpful? Is there anything in particular that needs 
> > extensive testing?
> 
> One of the best things people can do is just use it. OSDL and others run
> stress tests but often its users configurations that find bugs not
> stress and coverage runs.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Craig Thomas <craiger@osdl.org>
OSDL

