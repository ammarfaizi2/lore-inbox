Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbTADTeu>; Sat, 4 Jan 2003 14:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbTADTeu>; Sat, 4 Jan 2003 14:34:50 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:5334 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S261333AbTADTet>; Sat, 4 Jan 2003 14:34:49 -0500
Date: Sun, 05 Jan 2003 08:43:02 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Matan Ziv-Av <matan@svgalib.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
Message-ID: <570510000.1041709382@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21_heb2.09.0301042115010.5981-100000@matan.home>
References: <Pine.LNX.4.21_heb2.09.0301042115010.5981-100000@matan.home>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which is all nice and good, but trying to do this in order to suspend a 
laptop is going to result in vastly more code, and you just can't get the 
documentation.

After all, the vendor gave you the code with the hardware in this case, so 
it's not as if you can possibly not have a license for it :-)

Andrew

--On Saturday, January 04, 2003 21:31:38 +0200 Matan Ziv-Av 
<matan@svgalib.org> wrote:

> On Sat, 4 Jan 2003, Andrew McGregor wrote:
>
>> Or else find that the NV3x has some stonking quick CPU embedded, and apps
>> talk GLX to it...
>>
>> Strange how noone objects to APM BIOS calls or ACPI.
>
> Actually, I object to this.
> On my via 686a, the advice on this list for getting the power saving was
> to use ACPI (after setting some bits in PCI config space). But lvcool
> program showed how to do this without proprietary programs, and I
> adapted it to bit of kernel code:
>

<snip>

>
> And I don't need to run any proprietary code during normal system run. I
> still need to use BIOS to boot and to poweroff the system, but
> that will be solved as well.
>
>
> --
> Matan Ziv-Av.                         matan@svgalib.org
>
>
>


