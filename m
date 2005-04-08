Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVDHDf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVDHDf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDHDf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:35:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39811 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262666AbVDHDfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:35:45 -0400
Message-ID: <4255FBFC.3050602@pobox.com>
Date: Thu, 07 Apr 2005 23:35:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Phillips <phillips@istop.com>, Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <16980.55403.190197.751840@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org> <200504071300.51907.phillips@istop.com> <Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Warning: 24.25.22.197 is listed at orbz.gst-group.uk.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 7 Apr 2005, Daniel Phillips wrote:
> 
>>In that case, a nice refinement is to put the sequence number at the end of 
>>the subject line so patch sequences don't interleave:
> 
> 
> No. That makes it unsortable, and also much harder to pick put which part 
> of the subject line is the explanation, and which part is just metadata 
> for me.
> 
> So my prefernce is _overwhelmingly_ for the format that Andrew uses (which 
> is partly explained by the fact that I am used to it, but also by the fact 
> that I've asked for Andrew to make trivial changes to match my usage).
> 
> That canonical format is:
> 
> 	Subject: [PATCH 001/123] [<area>:] <explanation>
> 
> together with the first line of the body being a
> 
> 	From: Original Author <origa@email.com>


Nod.  For future reference, people can refer to

http://linux.yyz.us/patch-format.html
	and/or
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

	Jeff


