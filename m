Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272452AbRIKNBM>; Tue, 11 Sep 2001 09:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272448AbRIKNA7>; Tue, 11 Sep 2001 09:00:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27059 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272449AbRIKNAs>;
	Tue, 11 Sep 2001 09:00:48 -0400
Date: Tue, 11 Sep 2001 18:35:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: alan@lxorguk.ukuu.org.uk
Cc: Paul Mckenney <paul.mckenney@us.ibm.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911183534.A2340@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15gmqD-0002YK-00@the-village.bc.nu> you wrote:
>> BTW, I fixed a few more issues in the rcu patch (grep for
>> down_interruptible for instance), here an updated patch (will be
>> included in 2.4.10pre8aa1 [or later -aa]) with the name of rcu-2.

> I've been made aware of one other isue with the RCU patch
> US Patent #05442758

> In the absence of an actual real signed header paper patent use grant for GPL 
> usage from the Sequent folks that seems to be rather hard to fix.

> Alan

Hi Alan,

IBM bought us a couple of years ago and linux RCU is an IBM approved 
project. I am not sure I understand what exactly is needed for patent use 
grant for GPL, but whatever it is, I see absolutely no problem getting it done.
I would appreciate if you let me know what is needed for GPL.

Thanks
Dipankar 
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
