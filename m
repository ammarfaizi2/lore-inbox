Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVEVRR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVEVRR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVEVRR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 13:17:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23516 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261838AbVEVRRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 13:17:54 -0400
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi
	SuperIO chip
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk
In-Reply-To: <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
	 <1116763033.19183.14.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 22 May 2005 18:15:20 +0100
Message-Id: <1116782121.19183.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-22 at 09:59 -0700, Linus Torvalds wrote:
> So for now, it looks like we either have to make sure that rmk is 
> comfortable with not editing sign-off's (working on it, but I can't 
> guarantee anything), or that you're ok with getting the email stripped, 
> _or_ you will end up having to send patches directly to me rather than to 
> rmk (and face the chaos and bumbling that is Linus).

I think I can handle the chaos and bumbling that is Linus. In fact I
sent this one to Andrew to give it a bit of exposure in the -mm tree
first, but since it's a serial patch I also copied it to Russell as a
courtesy. 

Russell has now said that he committed it by accident, and from that I
infer that he's not going to make a habit of it. So that ought to
suffice for now.

The government department responsible for administering the DPA has a
'Data Protection Help-Line' which I have asked to clarify the situation;
it shouldn't be necessary to pay lawyers to do it. But then again, I can
well imagine that they'll simply refer me to the Act itself rather than
giving a coherent answer, so maybe a paid opinion would be useful.

-- 
dwmw2

