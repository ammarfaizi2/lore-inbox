Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272343AbRIKJem>; Tue, 11 Sep 2001 05:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272345AbRIKJeb>; Tue, 11 Sep 2001 05:34:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18894 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272343AbRIKJeQ>;
	Tue, 11 Sep 2001 05:34:16 -0400
Date: Tue, 11 Sep 2001 15:09:46 +0530
From: Maneesh Soni <smaneesh@sequent.com>
To: andrea@suse.de
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911150946.A14621@sequent.com>
Reply-To: smaneesh@sequent.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20010910200344.C714@athlon.random> you wrote:
> Long term of course, but with my further changes before the inclusion
> the plain current patches shouldn't apply any longer, I'd like if the
> developers of the current rcu fd patches could check my changes and
> adapt them (if they agree with my changes of course ;).

Hello Andrea,

I have noted your changes and I am modifying the FD patch accordingly. In fact
in the first version of FD patch I have used the rc_callback() interface which
equivalent to call_rcu(). 

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center,
IBM India Software Lab, Bangalore.
Phone: +91-80-5262355 Extn. 3999
email: smaneesh@sequent.com
http://lse.sourceforge.net/locking/rclock.html
