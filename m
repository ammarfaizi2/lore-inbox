Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSIFMkT>; Fri, 6 Sep 2002 08:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318552AbSIFMkT>; Fri, 6 Sep 2002 08:40:19 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:9700 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318546AbSIFMkS>; Fri, 6 Sep 2002 08:40:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Axel Siebenwirth <axel@hh59.org>, Christoph Hellwig <hch@infradead.org>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OOPS:2.5.33] Re: [Jfs-discussion] crash with JFS assert
Date: Fri, 6 Sep 2002 07:44:43 -0500
X-Mailer: KMail [version 1.4]
Cc: rml@tech9.net, akpm@zip.com.au
References: <Pine.LNX.4.43.0209051006480.887-100000@leo.uni-sw.gwdg.de> <20020906010641.A24706@infradead.org> <20020906001602.GA393@prester.freenet.de>
In-Reply-To: <20020906001602.GA393@prester.freenet.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209060744.43231.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 19:16, Axel Siebenwirth wrote:
> Aaaah! I got it. I just wanted to write an email expressing that for
> some strange reason latest 2.4 kernels (2.4.19-ac4,
> 2.4.20-pre5+latest ACPI) work without a problem.
> You know what the difference to my 2.5 kernels is..... CONFIG_PREEMPT
> is not enabled with my 2.4 kernels but with 2.5 it is!
>
> Here we go.
>
> Maybe someone can now get an idea on what the problem is and maybe
> how to fix it?!

Okay, I haven't played around with CONFIG_PREEMPT.  I probably won't get 
to it until Monday, but I'll see if I can reproduce this one now.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

