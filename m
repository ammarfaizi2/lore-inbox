Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285605AbRLGWRB>; Fri, 7 Dec 2001 17:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285606AbRLGWQv>; Fri, 7 Dec 2001 17:16:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13071 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285605AbRLGWQo>; Fri, 7 Dec 2001 17:16:44 -0500
Message-ID: <3C113FB1.2000AFF1@zip.com.au>
Date: Fri, 07 Dec 2001 14:16:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: release() locking
In-Reply-To: <3C10D83E.81261D74@delusion.de> <3C10FDCF.D8E473A0@zip.com.au> <3C11394D.90101@us.ibm.com> <3C113D78.F324F1B9@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> I guess there's something wrong with the changes you made, and it only
> shows with the modifications that Andrew made - and since he says he
> only fixed some bits of the code, the broken bits must have been there
> before.

Maybe so.  Can you identify the exact kernel version at which
the problem started?
