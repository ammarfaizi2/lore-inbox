Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSK0RVD>; Wed, 27 Nov 2002 12:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSK0RVD>; Wed, 27 Nov 2002 12:21:03 -0500
Received: from bitmover.com ([192.132.92.2]:22499 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264628AbSK0RVC>;
	Wed, 27 Nov 2002 12:21:02 -0500
Date: Wed, 27 Nov 2002 09:28:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Richard B. Tilley  (Brad)" <rtilley@vt.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Verifying Kernel source
Message-ID: <20021127092818.Q24374@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Richard B. Tilley  (Brad)" <rtilley@vt.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1038408874.12143.14.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1038408874.12143.14.camel@oubop4.bursar.vt.edu>; from rtilley@vt.edu on Wed, Nov 27, 2002 at 09:54:34AM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the proper way to verify the kernel source before compiling?
> There have been too many trojans of late in open source and free
> software and I, for one, am getting paranoid.

If it's in BK you can be pretty sure that it is what was checked in,
BK checksums every diff in every file.  It's not at all impossible
to fool the checksum but it is very unlikely that you can cause 
semantic differences in the form of a trojan horse and still fool 
the checksums.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
