Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289924AbSAKMIa>; Fri, 11 Jan 2002 07:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289926AbSAKMIV>; Fri, 11 Jan 2002 07:08:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36737 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289924AbSAKMIJ>;
	Fri, 11 Jan 2002 07:08:09 -0500
Date: Fri, 11 Jan 2002 04:07:15 -0800 (PST)
Message-Id: <20020111.040715.48529485.davem@redhat.com>
To: timothy.covell@ashavan.org
Cc: zhengpei@msu.edu, linux-kernel@vger.kernel.org
Subject: Re: strange kernel message when hacking the NIC driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201111159.g0BBxCSr001144@svr3.applink.net>
In-Reply-To: <LIECKFOKGFCHAPOBKPECEEGCCNAA.zhengpei@msu.edu>
	<200201110524.g0B5OeSr000566@svr3.applink.net>
	<200201111159.g0BBxCSr001144@svr3.applink.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Timothy Covell <timothy.covell@ashavan.org>
   Date: Fri, 11 Jan 2002 05:55:20 -0600

   Let me clarify what I said earlier.  You cannot have
   identical MAC addresses on two different NICs.

There is nothing illegal about that at all.  As long at
the NICs live on different subnets, it is perfectly fine.
In fact this is pretty common on Sun machines.
