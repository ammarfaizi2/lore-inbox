Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273537AbRIQI2T>; Mon, 17 Sep 2001 04:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273536AbRIQI2J>; Mon, 17 Sep 2001 04:28:09 -0400
Received: from pat.uio.no ([129.240.130.16]:56204 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S273534AbRIQI1x>;
	Mon, 17 Sep 2001 04:27:53 -0400
MIME-Version: 1.0
Message-ID: <15269.45902.377383.360402@charged.uio.no>
Date: Mon, 17 Sep 2001 10:24:46 +0200
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac11
In-Reply-To: <m366ail5pp.fsf@giants.mandrakesoft.com>
In-Reply-To: <200109170049.f8H0nkEa008317@sleipnir.valparaiso.cl>
	<m366ail5pp.fsf@giants.mandrakesoft.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chmouel Boudjnah <chmouel@mandrakesoft.com> writes:

     > http://marc.theaimsgroup.com/?l=linux-kernel&m=100019824200351&w=2

BTW: This is *not* the patch that went into Linus' tree. The above
version has a bug in the replacement for locks_delete_lock() that was
fixed in the final patch (which was posted on L-K later that same
day).

 AFAICS, ac11 contains the same patch that is in Linus' tree. It is
 correct.

Cheers,
   Trond
