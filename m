Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273360AbRI0PcG>; Thu, 27 Sep 2001 11:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRI0Pb4>; Thu, 27 Sep 2001 11:31:56 -0400
Received: from pat.uio.no ([129.240.130.16]:45957 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S273360AbRI0Pbv>;
	Thu, 27 Sep 2001 11:31:51 -0400
To: jstrand1@rochester.rr.com (James D Strandboge)
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: status of nfs and tcp with 2.4
In-Reply-To: <20010927105321.A15128@rochester.rr.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Sep 2001 17:32:09 +0200
In-Reply-To: jstrand1@rochester.rr.com's message of "Thu, 27 Sep 2001 10:53:21 -0400"
Message-ID: <shssnd88xae.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == James D Strandboge <jstrand1@rochester.rr.com> writes:

     > What is the status of tcp and nfs with the 2.4 kernel?  The
     > sourceforge site (regarding this) has not changed for a while
     > and the NFS FAQ at sourceforge simply states: nfsv3 over tcp
     > does not work - the code for 2.4.x is as yet to be merged

     > What progress is being made toward this end?

None: AFAIK nobody has yet written any code that works for the server.

The client works though...

Cheers,
   Trond
