Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSHBRKR>; Fri, 2 Aug 2002 13:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSHBRKR>; Fri, 2 Aug 2002 13:10:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23047 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316512AbSHBRKP>; Fri, 2 Aug 2002 13:10:15 -0400
Date: Fri, 2 Aug 2002 18:13:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Message-ID: <20020802181343.A15483@flint.arm.linux.org.uk>
References: <Pine.LNX.4.33.0208011425410.1612-100000@penguin.transmeta.com> <20020802012517.GA196@prester.freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020802012517.GA196@prester.freenet.de>; from axel@hh59.org on Fri, Aug 02, 2002 at 03:25:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 03:25:17AM +0200, Axel Siebenwirth wrote:
> building 2.5.30 fails at serial driver 8250 in file 8250.c compiled as
> module.

Oddly, other people appear to be able to build it fine.  Could you start
from a brand new 2.5.30 source and try again with the same configuration
please?

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

