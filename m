Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSAGJdp>; Mon, 7 Jan 2002 04:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289155AbSAGJde>; Mon, 7 Jan 2002 04:33:34 -0500
Received: from dlezb.ext.ti.com ([192.91.75.132]:64400 "EHLO go4.ext.ti.com")
	by vger.kernel.org with ESMTP id <S286821AbSAGJdW>;
	Mon, 7 Jan 2002 04:33:22 -0500
Message-ID: <3C396B45.6040702@ti.com>
Date: Mon, 07 Jan 2002 10:32:53 +0100
From: christian e <cej@ti.com>
Organization: Texas Instruments A/S,Denmark
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade performance still suck :-(
In-Reply-To: <3C386DC9.307@ti.com> <20020106170204.7e04e81f.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:


> Besides the fact I couldn't identify the kernel version from your mail, I would
> try:
> 
> 1) Turn off swap, then
> 2) Use 2.4.17 with patch I send you off LKML.
> 
> Then give us a hint if things got better.



Sorry forgot that.Currently running 2.4.17-mjc1.
Turning off swap is apparently not an option 'cause now VMware won't run 
anymore (really a swap happy app if I ever saw one :o) I get this error 
when starting to log on to my virtual Windows XP Pro:

AIO: unexpected loss of channel ide0:0 (thread ide 0:0)

and turning swap back on it runs with no problems..*sigh*
Can I make a RAM drive and then use that for swap ??Will the patch you 
sent me work with swap turned on ??

For info my system:

Dell latitude cpx j650GT,650 MHz P3
512 MB mem
12 GB hdd
3com 3c575ct pcmcia NIC
Debian woody
kernel 2.4.17-mjc1

running in a dock station with Nvidia TNT2 32 MB graphic card


that should be all..

best regards

Christian

