Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSGLQNn>; Fri, 12 Jul 2002 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSGLQNm>; Fri, 12 Jul 2002 12:13:42 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2291 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316609AbSGLQNl>;
	Fri, 12 Jul 2002 12:13:41 -0400
Date: Fri, 12 Jul 2002 21:50:39 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Maneesh Soni <maneesh@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, Al Viro <viro@math.psu.edu>
Subject: Re: [Lse-tech] [RFC] dcache scalability patch (2.4.17)
Message-ID: <20020712215039.B22916@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020712193935.B13618@in.ibm.com> <20020712151322.B31480@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020712151322.B31480@infradead.org>; from hch@infradead.org on Fri, Jul 12, 2002 at 03:13:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 03:13:22PM +0100, Christoph Hellwig wrote:
> 
> Else the patch looks fine to me, although I'm wondering why you target 2.4.17

Just to clarify from the project standpoint - we are *not* targeting
2.4.X. 2.4.X is what was used for ongoing performance measurement
work and we had to hop on to that bandwagon. It was just a proof
of concept.

We will publish the 2.5 stuff soon.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
