Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWAUX5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWAUX5w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWAUX5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:57:52 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:16997 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751234AbWAUX5v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:57:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TwzhETLPhMEg1xzFVAOPfCgT3fkXJUgL3mGuFhPpJ3+4zyDN1wgxKIsUjQW0xv00RAoH/E3ju4dWMl0K0jXZSioQoBFxJ7GP3FnrZfFMqGJFTIXPvtxa6h/w1FPgR1WJkrBaLCCWEoOmhUBNT/zYqeMkzgbGGeVWcXv+ofiXoP4=
Message-ID: <986ed62e0601211557s6da09160jce9884ff6b861006@mail.gmail.com>
Date: Sat, 21 Jan 2006 15:57:50 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Ed Tomlinson <edt@aei.ca>
Subject: Re: 2.6.16-rc1-mm2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, jgarzik@pobox.com, linux-scsi@vger.kernel.org
In-Reply-To: <200601211636.24693.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	 <200601211139.29019.edt@aei.ca>
	 <986ed62e0601211045p4a61a7c2v91d401af86f50d6@mail.gmail.com>
	 <200601211636.24693.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/06, Ed Tomlinson <edt@aei.ca> wrote:
[snip]
> smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
[snip]
> Error logging capability:        (0x01) Error logging supported.
>                                         General Purpose Logging supported.
[snip]
>
> SMART Error Log Version: 1
> No Errors Logged
[snip]
> I suspect the newer kernel (or kernels) since when I revert to 15-rc5-mm3 all is well.

That's what it looks like to me, too. Weird...

--
-Barry K. Nathan <barryn@pobox.com>
