Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSHMPPK>; Tue, 13 Aug 2002 11:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSHMPPK>; Tue, 13 Aug 2002 11:15:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62200 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318151AbSHMPPJ>;
	Tue, 13 Aug 2002 11:15:09 -0400
Date: Tue, 13 Aug 2002 08:15:53 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: colpatch@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
Message-ID: <1850510493.1029226552@[10.10.2.3]>
In-Reply-To: <1029250668.22847.34.camel@irongate.swansea.linux.org.uk>
References: <1029250668.22847.34.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I pointed out before the null check was flawed. And all I see is the
> same identical patch churned out again. Regardless of whether that
> paticular stupid error was in the old code, not fixing it in the new
> code when its pointed out is a bit of a mess.
> 
> I'm not sure its a simplification either. More function pointers don't
> always make for neater - but thats a side issue. If the NULL check goes
> I'm not too worried about the other stuff.

OK, that's easily disposed of, and it'll remove even more lines of
redundant code.

Thanks,

M.

