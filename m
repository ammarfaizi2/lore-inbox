Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbTBRAeg>; Mon, 17 Feb 2003 19:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTBRAef>; Mon, 17 Feb 2003 19:34:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59658 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267057AbTBRAef>;
	Mon, 17 Feb 2003 19:34:35 -0500
Message-ID: <3E5181D8.6040109@pobox.com>
Date: Mon, 17 Feb 2003 19:44:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62 --- spontaneous reboots
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <20030218000304.GA7352@f00f.org>
In-Reply-To: <20030218000304.GA7352@f00f.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Mon, Feb 17, 2003 at 03:18:43PM -0800, Linus Torvalds wrote:
> 
> 
>>Oh, and as a sign that 2.6.x really _is_ approaching, people have
>>started sending me spelling fixes.
> 
> 
> FWIW, I can't get 2.5.59+ (maybe earlier) to run reliably for me
> without spontaneous rebooting under load (kernel compile in a loop).


ACPI, or no?

highmem, or no?

Are you running your UP Athlon with CONFIG_X86_UP_APIC?

	Jeff



