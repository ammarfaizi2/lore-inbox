Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbTEALoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTEALoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:44:39 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:33752 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261219AbTEALog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:44:36 -0400
Date: Thu, 1 May 2003 07:54:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel source tree splitting
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305010756_MC3-1-36E1-623@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>> So there are many edits that needed to be done in lots of
>> Kconfig and Makefiles if one selectively pulls or omits certain
>> sub-directories.
>
> Indeed, I ran across the same thing a while back. Would be *really* nice to
> fix, if only so some poor sod over a modem can download a smaller tarball,
> or save some diskspace.

 I have seven source trees on disk right now.  Getting rid off all
the archs but i386 would not only save tons of space, it would also
make 'grep -r' go faster and stop spewing irrelevant hits for archs
that I couldn't care less about.


------
 Chuck
