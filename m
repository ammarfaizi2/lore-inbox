Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136441AbREDPsK>; Fri, 4 May 2001 11:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136438AbREDPsA>; Fri, 4 May 2001 11:48:00 -0400
Received: from wks79.navicsys.com ([207.180.73.79]:8927 "EHLO noop")
	by vger.kernel.org with ESMTP id <S136433AbREDPrr>;
	Fri, 4 May 2001 11:47:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: console=ttyS0 doesn't work 2.4.4
In-Reply-To: <m3zoct9peg.fsf@yahoo.com>
From: Nick Papadonis <npapadon@yahoo.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 04 May 2001 11:44:49 -0400
In-Reply-To: <m3zoct9peg.fsf@yahoo.com> (Nick Papadonis's message of "04 May 2001 10:09:43 -0400")
Message-ID: <m3wv7x6rv2.fsf@yahoo.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solved.  Disregard.  I didn't have serial console support compiled in.

Nick Papadonis <npapadon@yahoo.com> writes:

> I compiled the Linux kernel v2.4.4 and can't get 'console=ttyS0,115200
> console=tty0' to work.  This appended line works fine when I boot
> into my 2.2.x series kernel.
> 
> Anyone have similar problems?  Has anyone verified serial console
> output works with the 2.4.x kernels?  Thanks.
> 
> - Nick
