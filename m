Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285408AbRLNQYv>; Fri, 14 Dec 2001 11:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285409AbRLNQYr>; Fri, 14 Dec 2001 11:24:47 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:58889 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285404AbRLNQYL>; Fri, 14 Dec 2001 11:24:11 -0500
Date: Fri, 14 Dec 2001 16:22:53 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tim Waugh <twaugh@redhat.com>
Cc: Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move SIIG combo cards support to parport_serial.c
Message-ID: <20011214162253.A15589@flint.arm.linux.org.uk>
In-Reply-To: <20011215165739.A201@pazke.ipt> <20011214135749.S14588@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011214135749.S14588@redhat.com>; from twaugh@redhat.com on Fri, Dec 14, 2001 at 01:57:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 01:57:49PM +0000, Tim Waugh wrote:
> On Sat, Dec 15, 2001 at 04:57:39PM +0300, Andrey Panin wrote:
> 
> > Untested, but compiles and should work :))
> > 
> > These patches were sended to LKML some months ago, but seems like they 
> > was lost somewhere and I can't remember any answer.
> 
> I'm waiting for someone to tell me that it still works. :-)

I'm still waiting for people to test out the new serial layer and
report all the bugs that are bound to be in there. 8)

One you're happy with the changes, I'll put them into my serial cvs.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

