Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSG2VkN>; Mon, 29 Jul 2002 17:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSG2VkN>; Mon, 29 Jul 2002 17:40:13 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:51640 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318122AbSG2VkM>; Mon, 29 Jul 2002 17:40:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Axel Siebenwirth <axel@hh59.org>,
       JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.27: JFS oops
Date: Mon, 29 Jul 2002 16:43:14 -0500
X-Mailer: KMail [version 1.4]
References: <20020729150634.GA661@prester.freenet.de>
In-Reply-To: <20020729150634.GA661@prester.freenet.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207291643.14602.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 10:06, Axel Siebenwirth wrote:
> Hi Dave,
>
> here goes another jfsCommit oops from kernel 2.5.27.

I haven't seen this trap before.  I'll take a closer look at it, and let 
you know what I find.

> Can I use jfs from cvs with current kernels (2.5.29/2.4.19-rc3-ac3)
> to see how latest changes work?

Yes.  You should be able to just replace everything under fs/jfs with 
what's in cvs.
>
> Best regards,
> Axel Siebenwirth

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

