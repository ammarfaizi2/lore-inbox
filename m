Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136135AbREJMJU>; Thu, 10 May 2001 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136106AbREJMJD>; Thu, 10 May 2001 08:09:03 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136104AbREJMDO>;
	Thu, 10 May 2001 08:03:14 -0400
Date: Thu, 10 May 2001 14:10:50 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: "Andrew M. Theurer" <atheurer@austin.ibm.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Re: [Lse-tech] Re: Linux 2.4 Scalability, Samba, and Netbench
Message-ID: <20010510141050.D928@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <3AF97062.42465A53@austin.ibm.com> <20010509095658.B1150@w-mikek2.sequent.com> <3AF97EBB.9F0ABE9A@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AF97EBB.9F0ABE9A@austin.ibm.com>; from atheurer@austin.ibm.com on Wed, May 09, 2001 at 12:30:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

You would need contact one of the administrators of the LSE project for this.
You would need a developer id for uploading. You can get all the information 
from http://sourceforge.net/projects/lse/.

I think it will be very helpful to have the results including lockmeter
and kernprof data available in lse.sourceforge.net.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@sequent.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

On Wed, May 09, 2001 at 12:30:35PM -0500, Andrew M. Theurer wrote:
> I do have kernprof ACG and lockmeter for a 4P run.  We saw no
> significant problems with lockmeter.  csum_partial_copy_generic was the
> highest % in profile, at 4.34%.  I'll see if we can get some space on
> http://lse.sourceforge.net to post the test data.
> 
> Andrew Theurer
> 
> Mike Kravetz wrote:
> > 
> > On Wed, May 09, 2001 at 11:29:22AM -0500, Andrew M. Theurer wrote:
> > >
> > > I am evaluating Linux 2.4 SMP scalability, using Netbench(r) as a
> > > workload with Samba, and I wanted to get some feedback on results so
> > > far.
> > 
> > Do you have any kernel profile or lock contention data?
> > 
> > --
> > Mike Kravetz                                 mkravetz@sequent.com
> > IBM Linux Technology Center
> 
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/lse-tech

