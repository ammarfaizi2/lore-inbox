Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135368AbRARNDl>; Thu, 18 Jan 2001 08:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135554AbRARNDb>; Thu, 18 Jan 2001 08:03:31 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:24964 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S135368AbRARNDU>;
	Thu, 18 Jan 2001 08:03:20 -0500
Message-ID: <20010118210309.A8610@saw.sw.com.sg>
Date: Thu, 18 Jan 2001 21:03:09 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Simon Huggins <huggie@earth.li>
Cc: eepro100@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: eepro cmd_wait
In-Reply-To: <20010118131011.B19784@the.earth.li> <20010118201731.A8492@saw.sw.com.sg> <20010118134250.C19784@the.earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010118134250.C19784@the.earth.li>; from "Simon Huggins" on Thu, Jan 18, 2001 at 01:42:50PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 01:42:50PM +0100, Simon Huggins wrote:
> 
> On Thu, Jan 18, 2001 at 08:17:31PM +0800, Andrey Savochkin wrote:
[snip]
> > These two line are a workaround for the RxAddrLoad timing bug,
> > developed by Donald Becker.  wait_for_cmd_done timeouts may be related
> > to this bug, too.
> 
> Well it now boots :)
> I'll let you know if there are any more problems with it in use.

It always boots, with different rate of successive ones.
The question is how _often_ it boots successfully now :-)

Best regards
		Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
