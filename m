Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289629AbSA2Onm>; Tue, 29 Jan 2002 09:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289631AbSA2Ond>; Tue, 29 Jan 2002 09:43:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53261 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289629AbSA2OnU>; Tue, 29 Jan 2002 09:43:20 -0500
Date: Tue, 29 Jan 2002 14:43:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Jones <davej@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129144307.B6542@flint.arm.linux.org.uk>
In-Reply-To: <E16VYVH-0003x8-00@the-village.bc.nu> <Pine.LNX.4.33.0201291706490.11065-100000@localhost.localdomain> <20020129152732.G9149@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020129152732.G9149@suse.de>; from davej@suse.de on Tue, Jan 29, 2002 at 03:27:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 03:27:32PM +0100, Dave Jones wrote:
> On Tue, Jan 29, 2002 at 05:15:15PM +0100, Ingo Molnar wrote:
>  > out of the 300+ email addresses in the MAINTAINERS file, 15 addresses
>  > bounced physically. (whether they bounce logically is another question.)
> 
>  Care to remove the bogus ones from MAINTAINERS and send it to Linus/Me?
>  (Keep the entries, but remove the address. (Or better perhaps to mark
>  it 'out of order' in case of mailserver failure on $maintainers side.)

If we're going to be doing this periodically, it might be an idea to
put "out of order since dd mmm yyyy" and a "last checked dd mmm yyyy"
at the top of the file.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

