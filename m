Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272312AbRH3Q0X>; Thu, 30 Aug 2001 12:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbRH3Q0O>; Thu, 30 Aug 2001 12:26:14 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:63917 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S272312AbRH3Q0A>; Thu, 30 Aug 2001 12:26:00 -0400
Date: Thu, 30 Aug 2001 17:26:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac4: undefined reference pgtable_cache_init
Message-ID: <20010830172612.F1149@flint.arm.linux.org.uk>
In-Reply-To: <3B8E6467.1030204@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8E6467.1030204@si.rr.com>; from fdavis@si.rr.com on Thu, Aug 30, 2001 at 12:05:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 12:05:59PM -0400, Frank Davis wrote:
> Hello,
>    During make bzImage, I received the following:
> 
> init/main.o: In function 'start_kernel'
> init/main.o(.text.init+0x842): undefined reference to 'pgtable_cache_init'

Which architecture are you building for?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

