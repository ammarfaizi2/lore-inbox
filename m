Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291436AbSBNLzf>; Thu, 14 Feb 2002 06:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291426AbSBNLz2>; Thu, 14 Feb 2002 06:55:28 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30654 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291436AbSBNLzO>;
	Thu, 14 Feb 2002 06:55:14 -0500
Date: Thu, 14 Feb 2002 17:27:09 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: alan@redhat.com, viro@math.psu.edu
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre9-ac3
Message-ID: <20020214172709.G8328@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan, 

In article <200202131317.g1DDHSQ14686@devserv.devel.redhat.com> you wrote:

> Linux 2.4.18pre3-ac2
> +/o/X	Fix locking of file struct stuff found by ibm	(Dipankar Sarma)
> 	audit

I can see that the audit patch has in-correct fix for proc_readfd. Can
you tell us if there is anything else wrong in the audit patch. I will re-do 
the patch.

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html
