Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129707AbQJ0RU4>; Fri, 27 Oct 2000 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129723AbQJ0RUq>; Fri, 27 Oct 2000 13:20:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7280 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129707AbQJ0RUg>; Fri, 27 Oct 2000 13:20:36 -0400
Subject: Re: GPL Question
To: djweis@sjdjweis.com (David Weis)
Date: Fri, 27 Oct 2000 18:21:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10010271130550.23907-100000@catbert.desm.plconline.com> from "David Weis" at Oct 27, 2000 11:31:52 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pDC5-0004g7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 27 Oct 2000, Jason Wohlgemuth wrote:
> 
> > Now, if a module is loaded that registers a set of functions that have 
> > increased functionality compared to the original functions, if that 
> > modules is not based off GPL'd code, must the source code of that module 
> > be released under the GPL?
> 
> It would probably follow GPL, but it's pretty slimy. I won't buy it.

It depends primarily if the module depends on the code which is GPL. Its all
a rather unclear area. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
