Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278958AbRKIAsN>; Thu, 8 Nov 2001 19:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278959AbRKIAsE>; Thu, 8 Nov 2001 19:48:04 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:5108 "EHLO e22.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S278958AbRKIArw>;
	Thu, 8 Nov 2001 19:47:52 -0500
Message-ID: <3BEB2739.4F8C8816@us.ibm.com>
Date: Thu, 08 Nov 2001 16:45:45 -0800
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH]Disk IO statisitics gathering for all disks
In-Reply-To: <3BEB0848.735652EF@us.ibm.com> <20011108233912.A5845@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> A very minor nitpick: please use struct dk_stat (or disk_stat) instead of
> dk_stat_t - it is by no means an opaque type.
> 

You are right.  Thank you for pointing it out. 

-- 
Mingming Cao
IBM Linux Technology Center
503-578-5024  IBM T/L: 775-5024
cmm@us.ibm.com
http://www.ibm.com/linux/ltc
