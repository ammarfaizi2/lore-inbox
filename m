Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbRGPKWb>; Mon, 16 Jul 2001 06:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbRGPKWL>; Mon, 16 Jul 2001 06:22:11 -0400
Received: from laxmls03.socal.rr.com ([24.30.163.17]:29628 "EHLO
	laxmls03.socal.rr.com") by vger.kernel.org with ESMTP
	id <S267159AbRGPKWD>; Mon, 16 Jul 2001 06:22:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Shane Nay <shane@minirl.com>
To: James Simmons <jsimmons@transvirtual.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [ANNOUNCE] Secondary mips tree.
Date: Mon, 16 Jul 2001 03:22:40 -0700
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.10.10107130800230.30223-100000@transvirtual.com>
In-Reply-To: <Pine.LNX.4.10.10107130800230.30223-100000@transvirtual.com>
MIME-Version: 1.0
Message-Id: <0107160322400A.02677@compiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 July 2001 08:01, James Simmons wrote:
> > Good. I should definitely take a look. [Do you care about vr4130 or about
> > tx3912, too?]
>
> Yes. If you want to work on it no problem.

Huh, Very Cool.  I was getting ready to queue up a huge IRDA forward port in 
linux-vr to the 2.4.6 version.  (Still el-crashola on me right now)  The one 
in the present repository likes to overwrite userspace applications pretty 
much at randomn.

Maybe after things simmer down I'll port the Agenda hardware platform over to 
your repository, and Agenda can switch to using that.  linux-vr has been 
really really stale since we froze at our present version for toolchain 
reasons.  Those toolchain problems were fixed ages ago, but Mike & Brad who 
had been responsible for forward porting the kernel stopped doing that work 
for the most part.

Thanks,
Shane Nay.
