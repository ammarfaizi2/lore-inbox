Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270525AbRHHRI1>; Wed, 8 Aug 2001 13:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270527AbRHHRIR>; Wed, 8 Aug 2001 13:08:17 -0400
Received: from www.grips.com ([62.144.214.31]:33800 "EHLO grips_nts2.grips.com")
	by vger.kernel.org with ESMTP id <S270525AbRHHRID>;
	Wed, 8 Aug 2001 13:08:03 -0400
Message-ID: <3B717220.8050308@grips.com>
Date: Wed, 08 Aug 2001 19:08:48 +0200
From: jury gerold <geroldj@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010701
X-Accept-Language: de-at, en
MIME-Version: 1.0
To: Gerbrand van der Zouw <g.vanderzouw@chello.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon/MSI mobo combo broken?
In-Reply-To: <20010723180201.A10557@convergence.de> <20010723183204.B27310@lightning.swansea.linux.org.uk> <3B6071F8.5090104@chello.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have PC100 SDRAM try to replace it with PC133.
This worked for my motherboard. (Gigabyte GA-7ZXR, VIA-KT133A, Athlon 
1.1MHz)

Cheers too

Gerold

Gerbrand van der Zouw wrote:

> Hi,
>
> Alan Cox wrote:
>
>> I'd be interested to know if 2.4.6-ac5 Athlon optimised works on your 
>> board.
>> The reason for this is that it contains the official VIA fixes for 
>> their IDE
>> corruption problem rather than our own.
>
>
> I have a MSI K7T Turbo (MS-6330) mobo (VIA-KT133A chipset) and had a 
> go with the 2.4.6-ac5 kernel with Athlon optimisations on. The overall 
> impression is that the combination is slightly more stable than 
> kernels without the Southbridge fix. I.e. I now manage to boot in 
> single user mode, however running anything as advanced as gcc is out 
> of the question: oopses all over the place and also some complaints 
> from the VM-system.
>
> I am in no way qualified enough to go hacking around in the kernel 
> myself, but am quite willing to test any patches that might help 
> towards solving the problem.
>
> Cheers,
>
> Gerbrand van der Zouw
>


