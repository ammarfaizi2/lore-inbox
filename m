Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276653AbRJPTju>; Tue, 16 Oct 2001 15:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276538AbRJPTjk>; Tue, 16 Oct 2001 15:39:40 -0400
Received: from james.kalifornia.com ([208.179.59.2]:20265 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S276653AbRJPTjU>; Tue, 16 Oct 2001 15:39:20 -0400
Message-ID: <3BCC8D0D.7020906@blue-labs.org>
Date: Tue, 16 Oct 2001 15:39:57 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011013
X-Accept-Language: en-us
MIME-Version: 1.0
To: James Stevenson <mail-lists@stev.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tcpdump filters, problem with UDP and 2.4.x
In-Reply-To: <3BC8A04A.5090108@blue-labs.org> <048a01c1555a$09d4e790$07fea8c0@stu2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, it is for DNS traffic.

James Stevenson wrote:

>>I see a lot of "UDP: bad checksum. ..." between two of my servers.  I
>>haven't attached a tcpdump output of the packets because a) the packets
>>between machine A and B travel through a GRE tunnel and b) does anyone
>>have tcpdump filters or know how to finagle tcpdump into dumping the
>>embedded packet instead of the GRE header'd packet?
>>
>id this for NFS udp traffic ?
>if it is then you will see it i have seen this on both 2.2.x and 2.4.x
>kernels
>it only shows up on the nfs server side for me though.
>


