Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267607AbTBEALB>; Tue, 4 Feb 2003 19:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTBEALA>; Tue, 4 Feb 2003 19:11:00 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25492 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267602AbTBEAKW>;
	Tue, 4 Feb 2003 19:10:22 -0500
Subject: Re: gcc 2.95 vs 3.21 performance
From: Andy Pfiffer <andyp@osdl.org>
To: b_adlakha@softhome.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <courier.3E404FD0.00004E4F@softhome.net>
References: <1044385759.1861.46.camel@localhost.localdomain>
	 <200302041935.h14JZ69G002675@darkstar.example.net>
	 <b1pbt8$2ll$1@penguin.transmeta.com>
	 <20030204232101.GA9034@work.bitmover.com>
	 <courier.3E404FD0.00004E4F@softhome.net>
Content-Type: text/plain
Organization: 
Message-Id: <1044404395.28335.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 04 Feb 2003 16:19:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 15:42, b_adlakha@softhome.net wrote:
> >> I'd love to see a small - and fast - C compiler, and I'd be willing to
> >> make kernel changes to make it work with it.  
> 
> tcc looks like a cool project to me...
> Its small enough to be distributed through this mailing list! 

Don't overlook lcc -- last I knew most users were using GNU's cpp, but
other than that, it is available for the curious:

http://www.cs.princeton.edu/software/lcc/




