Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261967AbTCQWuM>; Mon, 17 Mar 2003 17:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbTCQWuM>; Mon, 17 Mar 2003 17:50:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:53492 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261967AbTCQWuL>; Mon, 17 Mar 2003 17:50:11 -0500
Date: Mon, 17 Mar 2003 14:50:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.64-mjb4 (scalability / NUMA patchset)
Message-ID: <296760000.1047941431@flay>
In-Reply-To: <20030317044716.GA1256@gnuppy.monkey.org>
References: <85960000.1047532556@[10.10.2.4]> <10770000.1047787269@[10.10.2.4]> <20030316044524.GA6757@gnuppy.monkey.org> <12150000.1047793549@[10.10.2.4]> <20030316063151.GA7114@gnuppy.monkey.org> <19840000.1047797300@[10.10.2.4]> <20030316065650.GA8164@gnuppy.monkey.org> <20280000.1047798483@[10.10.2.4]> <20030316082911.GA777@gnuppy.monkey.org> <57410000.1047827453@[10.10.2.4]> <20030317044716.GA1256@gnuppy.monkey.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hmmm ... does just -bk3 do the same thing with the same config file?
>> I guess you could try the early_printk stuff, but ISTR either VGA
>> or serial was broken ... but I forget which ;-(. I'll try to fix
>> that up later.
> 
> There's a funny pause after decompression, but it starts up fine.
> Running from it now.
> 
> .config attached

Allegedly preempt is broken in -mjb ... can you try with it off?
that fixed Dave's problem ...

M.

