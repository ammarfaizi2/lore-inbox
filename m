Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSFNJQP>; Fri, 14 Jun 2002 05:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317894AbSFNJQO>; Fri, 14 Jun 2002 05:16:14 -0400
Received: from cpe.atm2-0-1071115.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:31914
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S317893AbSFNJQN>; Fri, 14 Jun 2002 05:16:13 -0400
Message-ID: <3D09B45D.8010903@fugmann.dhs.org>
Date: Fri, 14 Jun 2002 11:16:13 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020610 Debian/1.0.0-1
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bandwidth 'depredation' revisited
In-Reply-To: <200206140335.g5E3ZhF370974@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
> 
> Rather than dropping packets, causing retransmits that
> eat into your bandwidth, you could try the new ECN bits.
> If you're downloading from a Linux box, it ought to slow
> down a bit when you claim to be suffering congestion.
> 

Yes - That would really be ideal.
Do you know how to enable ECN on the ingress filter,
or which filter to use instead?

Anders

