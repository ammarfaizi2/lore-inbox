Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbSKGRHU>; Thu, 7 Nov 2002 12:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbSKGRHU>; Thu, 7 Nov 2002 12:07:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:12006 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261461AbSKGRHT>;
	Thu, 7 Nov 2002 12:07:19 -0500
Message-ID: <3DCA9F50.1A9E5EC5@digeo.com>
Date: Thu, 07 Nov 2002 09:13:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.46-mm1
References: <Pine.LNX.3.96.1021107113557.30525C-100000@gatekeeper.tmr.com> <4051130868.1036659083@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 17:13:53.0234 (UTC) FILETIME=[0C235320:01C28681]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > For what it's worth, the last mm kernel which booted on my old P-II IDE
> > test machine was 44-mm2. With 44-mm6 and this one I get an oops on boot.
> > Unfortunately it isn't written to disk, scrolls off the console, and
> > leaves the machine totally dead to anything less than a reset. I will try
> 
> Any chance of setting up a serial console? They're very handy for
> things like this ...
> 

"vga=extended" gets you 50 rows, which is usually enough.
