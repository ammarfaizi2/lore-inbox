Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUH0UcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUH0UcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUH0U1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:27:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267561AbUH0UXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:23:35 -0400
Date: Fri, 27 Aug 2004 13:22:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Summarizing the PWC driver questions/answers
Message-Id: <20040827132204.17bb58f1.davem@redhat.com>
In-Reply-To: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 21:54:55 +0200
Kenneth Lavrsen <kenneth@lavrsen.dk> wrote:

> - What is your excuse for forcing us to throw away worth 2000 dollars of 
> cameras?

You, just like the rest of the world and even distribution makers if
they choose to do so, can patch the driver back into the kernel.

Just because it's not in the vanilla sources doesn't mean you can't
get a working setup.  Look at all the NVIDIA users out there. :-)
Are they moaning about how the vanilla kernel maintainers are making
them "throw away blah blah dollars of video cards"?  Absolutely not,
they load the binary-only blob, the go play quake3, and they're happy.

> - What is the next hardware or software - currently supported by Linux - 
> that you will allow being made impossible to use for whatever fanatic 
> reasons? (This is not exactly like the principles you stated in your book).

Not impossible, you're being rediculious, you can add the driver back
into the kernel you use just fine.  See above.
