Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUBWPvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUBWPvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:51:18 -0500
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:38560 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261915AbUBWPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:51:12 -0500
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
	<16435.14044.182718.134404@alkaid.it.uu.se>
	<Pine.LNX.4.58.0402180744440.2686@home.osdl.org>
	<20040222025957.GA31813@MAIL.13thfloor.at>
	<Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Mon, 23 Feb 2004 09:51:07 -0600
In-Reply-To: <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 21 Feb 2004 19:12:20 -0800 (PST)")
Message-ID: <yqujk72dyetw.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004, Linus Torvalds outgrape:
> Actually, I'm a bit disgusted at Intel for not even _mentioning_ AMD
> in their documentation or their releases, so I'd almost be inclined
> to rename the thing as "AMD64" just to give credit where credit is
> due. However, it's just not worth the pain and confusion.

I move we:

  s/ia64/itanic/g
  s/x86_64/ia64/g

and acknowledge that the "a" in "ia64" now stands for "AMD".
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
 Not everything derived from the base class "patentable" inherits the
       "non-obvious, "non-trivial", and "original" attributes.
