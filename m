Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282248AbRK2BX5>; Wed, 28 Nov 2001 20:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282251AbRK2BXq>; Wed, 28 Nov 2001 20:23:46 -0500
Received: from holomorphy.com ([216.36.33.161]:26292 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S282248AbRK2BXc>;
	Wed, 28 Nov 2001 20:23:32 -0500
Date: Wed, 28 Nov 2001 17:23:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011128172304.E3921@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com> <20011128010411.A14584@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011128010411.A14584@figure1.int.wirex.com>; from chris@wirex.com on Wed, Nov 28, 2001 at 01:04:11AM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 01:04:11AM -0800, Chris Wright wrote:
> test results from 32-bit SPARC (sun4m).
> 2.5.1-pre1+show_trace_task (patch form DaveM)
> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/bootmem/bootmem-2.5.1-pre1
> applied cleanly, compiled fine, but didn't boot.

I've conferred with Chris Wright and he's verified that after
a recompilation, the kernel with the bootmem patch booted successfully.


Chris, if you could chime in when your mail works again, I'd be
much obliged.


This patch has now been successfully tested on 32-bit SPARC.


Cheers,
Bill
