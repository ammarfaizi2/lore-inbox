Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285462AbRLGLha>; Fri, 7 Dec 2001 06:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285465AbRLGLhV>; Fri, 7 Dec 2001 06:37:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64224 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285462AbRLGLhK>; Fri, 7 Dec 2001 06:37:10 -0500
Date: Fri, 7 Dec 2001 17:09:36 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Niels Christiansen <nchr@us.ibm.com>, arjanv@redhat.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011207170936.I20583@in.ibm.com>
In-Reply-To: <OF5920A1C3.B32C93AF-ON85256B1A.005706AC@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF5920A1C3.B32C93AF-ON85256B1A.005706AC@raleigh.ibm.com>; from nchr@us.ibm.com on Thu, Dec 06, 2001 at 10:10:47AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niels, Arjan

On Thu, Dec 06, 2001 at 10:10:47AM -0600, Niels Christiansen wrote:
> 
> > Well, I wrote a simple kernel module which just increments a shared
> global
> > counter a million times per processor in parallel, and compared it with
> > the statctr which would be incremented a million times per processor in
> > parallel..
> 
> I suspected that.  Would it be possible to do the test on the real
> counters?

Yep, I am gonna run a benchmark after changing some stat counters in the
Kernel.  That should let us know if there are performance gains or otherwise..

Kiran
-- 
Ravikiran G Thirumalai <kiran@in.ibm.com>
Linux Technology Center, IBM Software Labs,
Bangalore.
