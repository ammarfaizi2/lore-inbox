Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316015AbSEJPJz>; Fri, 10 May 2002 11:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316016AbSEJPJy>; Fri, 10 May 2002 11:09:54 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:49926 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316015AbSEJPJx>; Fri, 10 May 2002 11:09:53 -0400
Date: Fri, 10 May 2002 16:09:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to redirect serial console to telnet session?
Message-ID: <20020510160945.B7165@flint.arm.linux.org.uk>
In-Reply-To: <3CDBC5A5.A1844CC0@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 09:05:41AM -0400, Chris Friesen wrote:
> Accordingly, I grabbed what looked like the important bits of xconsole, but it
> appears that this only gets me stuff written to /dev/console from userspace. 
> How do I go about getting the output of kernel-level printk()s as well?

Check the LKML archives for something called 'netconsole' (or use google).
It got mentioned here about 6 months to a year ago.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

