Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTBOSfh>; Sat, 15 Feb 2003 13:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTBOSfh>; Sat, 15 Feb 2003 13:35:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21007 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264838AbTBOSfh>;
	Sat, 15 Feb 2003 13:35:37 -0500
Message-ID: <3E4E8AB0.4040600@pobox.com>
Date: Sat, 15 Feb 2003 13:45:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.61
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com> <20030215183555.A22045@infradead.org>
In-Reply-To: <20030215183555.A22045@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

Is Linus really the right person to direct these to?


>>  o use per-cpu data for ia32 profiler
> 
> 
> any reason you only changed prof_counter to pr-cpu data and not the
> two NR_CPUS arrays above it?
> 
> 
>>  o acpi: Split i386 support up
> 
> 
> Shouldn't this be in arch/i386/acpi/ instead of arch/i386/kernel/acpi/

Agreed, though Pat or Andy G are better people to tell this... it's only 
a "bk mv" away for either of them :)

