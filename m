Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSGLRzR>; Fri, 12 Jul 2002 13:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSGLRzQ>; Fri, 12 Jul 2002 13:55:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8658 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316739AbSGLRzP>;
	Fri, 12 Jul 2002 13:55:15 -0400
Date: Fri, 12 Jul 2002 23:32:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17)
Message-ID: <20020712233205.B23363@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020712193935.B13618@in.ibm.com> <Pine.GSO.4.21.0207121021430.11261-100000@weyl.math.psu.edu> <20020712214008.A22916@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020712214008.A22916@in.ibm.com>; from dipankar@in.ibm.com on Fri, Jul 12, 2002 at 09:40:08PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 09:40:08PM +0530, Dipankar Sarma wrote:
> On Fri, Jul 12, 2002 at 10:29:53AM -0400, Alexander Viro wrote:
> > Where is
> > 	* version for 2.5.<current>
> > 	* analysis of benefits in real-world situations for 2.5 version?
> 
> I know that 2.5 patches are available, but Maneesh will probably
> respond to this on Monday.
> 
> I am working on getting 2.5 measurements done. BTW, would you consider
> specweb99 reasonably real-world ? If not, do you have any suggestions 
> for benchmarks ? I suspect that dbench wouldn't cut it ;-).

Hi Al,

Mark Hahn made a good point over private email that real-worldness
also includes hardware. I will dig around and see if we can work out
a setup with different dual/4CPU hardware to do webserver benchmarks 
and analyze results for 2.5 patches.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
