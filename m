Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTBYTsA>; Tue, 25 Feb 2003 14:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTBYTsA>; Tue, 25 Feb 2003 14:48:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:62877 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267548AbTBYTr7>; Tue, 25 Feb 2003 14:47:59 -0500
Date: Tue, 25 Feb 2003 11:48:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Cliff White <cliffw@osdl.org>
cc: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call 
Message-ID: <414510000.1046202507@flay>
In-Reply-To: <200302251711.h1PHBct16624@mail.osdl.org>
References: <200302251711.h1PHBct16624@mail.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting items for me are the fork/exec/sh times and some of the file
> + VM  numbers

For the ones where you see degradation in fork/exec type stuff, any chance
you could rerun them with 62-mjb3 with the objrmap stuff in it? That should
fix a lot of the overhead.

Thanks,

M.

