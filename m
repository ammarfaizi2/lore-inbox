Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272316AbRH3QYX>; Thu, 30 Aug 2001 12:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272314AbRH3QYN>; Thu, 30 Aug 2001 12:24:13 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:22536 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S272312AbRH3QYA>; Thu, 30 Aug 2001 12:24:00 -0400
Date: Thu, 30 Aug 2001 17:23:46 +0100 (BST)
From: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: <dwmw2@imladris.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: lcs ethernet driver source
In-Reply-To: <E15cU4q-0001Hp-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108301720190.23048-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Alan Cox wrote:

> > Sorry, at this point we are not allowed to publish the source code of the
> > lcs and qeth drivers (due to the use of confidential hardware interface
> > specifications).  We make those modules available only in binary form
> > on our developerWorks web site.
> 
> Is there any plan to change this ? 

Erm, Linux on S/390 runs as a virtual machine, doesn't it? Does a lack of 
network drivers not render it completely useless?

If the architecture port is not sanely usable in the form in which it 
appears in the Linux kernel, then it should be removed from the tree.

-- 
dwmw2


