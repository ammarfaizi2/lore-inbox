Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUATAdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUATA1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:27:44 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:39046 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263523AbUATARc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:17:32 -0500
Date: Mon, 19 Jan 2004 16:17:32 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: joe.korty@ccur.com, akpm@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap parsing/printing routines, version 4
Message-Id: <20040119161732.54eb2b75.pj@sgi.com>
In-Reply-To: <400C4966.2030803@us.ibm.com>
References: <20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115161732.458159f5.pj@sgi.com>
	<400873EC.2000406@us.ibm.com>
	<20040117063618.GA14829@tsunami.ccur.com>
	<20040117183929.GA24185@tsunami.ccur.com>
	<400C4966.2030803@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew rrote:
> 3) Remove "totaldigits == 0" check at the end of bitmap_parse. 

I agree - that check looks redundant to me too.

> addition of a whole lotta comments.

cool.

> Andrew, I agree with Paul's "thumbs-up" of Joe's patch.

Thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
