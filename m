Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUAQJNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 04:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUAQJNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 04:13:30 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:8128 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265985AbUAQJNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 04:13:08 -0500
Date: Sat, 17 Jan 2004 01:12:45 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: joe.korty@ccur.com, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040117011245.73c2ab5e.pj@sgi.com>
In-Reply-To: <400873EC.2000406@us.ibm.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115161732.458159f5.pj@sgi.com>
	<400873EC.2000406@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think a 32-bit chunk-size is preferable.

I see that Joe has been persuaded by your points,
in his latest patch.

Good - 32 it is.  Thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
