Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSEUUdA>; Tue, 21 May 2002 16:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSEUUc7>; Tue, 21 May 2002 16:32:59 -0400
Received: from holomorphy.com ([66.224.33.161]:42638 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316589AbSEUUc6>;
	Tue, 21 May 2002 16:32:58 -0400
Date: Tue, 21 May 2002 13:32:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org,
        hedrick@kernel.org
Subject: Re: Kernel BUG 2.4.19-pre8-ac1 + preempt
Message-ID: <20020521203249.GK2046@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erik McKee <camhanaich99@yahoo.com>, linux-kernel@vger.kernel.org,
	hedrick@kernel.org
In-Reply-To: <20020521194349.67491.qmail@web14206.mail.yahoo.com> <20020521201739.GI2046@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 12:43:49PM -0700, Erik McKee wrote:
>> Trace; c0123e13 <handle_mm_fault+d7/178>
>> Trace; c01117ab <do_page_fault+117/430>
>> Trace; c0111694 <do_page_fault+0/430>
>> Trace; c01a7b0e <ide_do_request+29a/2e4>
>> Trace; c01a802c <ide_intr+16c/1ac>
>> Trace; c01abb58 <ide_dma_intr+0/a4>

On Tue, May 21, 2002 at 01:17:39PM -0700, William Lee Irwin III wrote:
> I suspect a 2.4 IDE vs. preempt interaction, Andre, any chance you could
> look at this?

Disregard that, brainfart. Continuing the hunt...


Cheers,
Bill
