Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbQLYUID>; Mon, 25 Dec 2000 15:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130475AbQLYUHx>; Mon, 25 Dec 2000 15:07:53 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:26130 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130355AbQLYUHs>; Mon, 25 Dec 2000 15:07:48 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200012251937.TAA07779@mauve.demon.co.uk>
Subject: Re: About Celeron processor memory barrier problem
To: kaih@khms.westfalen.de (Kai Henningsen)
Date: Mon, 25 Dec 2000 19:37:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7sX4YyEmw-B@khms.westfalen.de> from "Kai Henningsen" at Dec 25, 2000 01:12:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> timw@splhi.com (Tim Wright)  wrote on 24.12.00 in <20001224125023.A1900@scutter.internal.splhi.com>:
> 
> > On Sun, Dec 24, 2000 at 11:36:00AM +0200, Kai Henningsen wrote:
> 
> > There was a similar thread to this recently. The issue is that if you
> > choose the wrong processor type, you may not even be able to complain.
> 
> Hmm ... I think I can see ways around that (essentially similar to the 16  
> bit bootstrap code), but it may indeed be more trouble than it's worth.

What about a simple solution, 
"Ok, Booting the kernel for i486+fpu and above."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
