Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVLCTWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVLCTWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 14:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLCTWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 14:22:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751289AbVLCTWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 14:22:31 -0500
Date: Sat, 3 Dec 2005 11:22:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <lkml@rtr.ca>
cc: David Ranson <david@unsolicited.net>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-Reply-To: <4391E240.2020902@rtr.ca>
Message-ID: <Pine.LNX.4.64.0512031118520.3099@g5.osdl.org>
References: <20051203135608.GJ31395@stusta.de>  <1133620598.22170.14.camel@laptopd505.fenrus.org>
  <20051203152339.GK31395@stusta.de>  <20051203162755.GA31405@merlin.emma.line.org>
  <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain>
 <4391D335.7040008@unsolicited.net> <4391E240.2020902@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Dec 2005, Mark Lord wrote:

> David Ranson wrote:
> > 
> > Ahh OK .. I don't use it, so wouldn't have been affected. That's one
> > userspace interface broken during the series, does anyone have any more?
> 
> vbetool.

I don't think vbetool has been "broken", it should work fine again. It was 
just temporarily (and unintentionally) broken for a while.

But if it's still broken in 2.6.15-rc4, please do holler (with as many 
details as you can)

		Linus
