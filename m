Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268482AbTCFWvR>; Thu, 6 Mar 2003 17:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268481AbTCFWvR>; Thu, 6 Mar 2003 17:51:17 -0500
Received: from kilo.rb.xcalibre.co.uk ([217.204.38.22]:39174 "EHLO
	kilo.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id <S268482AbTCFWvQ>; Thu, 6 Mar 2003 17:51:16 -0500
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: [2.5.64-mm1] sysfs oops
Date: Thu, 6 Mar 2003 23:01:55 +0000
User-Agent: KMail/1.5.9
Cc: <linux-kernel@vger.kernel.org>, <thundercloud@devzero.co.uk>,
       <bonganilinux@mweb.co.za>
References: <Pine.LNX.4.33.0303061436030.994-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0303061436030.994-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303062301.56096.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 March 2003 20:38, Patrick Mochel wrote:
>
> Argh. A bk merge ate my change!
>

Hmm, I recall reporting this before, yes.

> This has been around for a while, and I merged a patch to fix it. However,
> a leter merge with previous work to split fs/sysfs/inode.c up reverted it
> back to the old code.
>
> Could you (both) try the following patch and let me know if it fixes it?

This fixes it. Thanks for the reply.

Cheers,
Alistair.

