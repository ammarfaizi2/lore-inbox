Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268140AbUHQIBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268140AbUHQIBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUHQIBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:01:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:1185 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268140AbUHQIA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:00:58 -0400
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David N. Welton" <davidw@dedasys.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <874qn353on.fsf@dedasys.com>
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	 <873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	 <87llgfdqb7.fsf@dedasys.com>  <874qn353on.fsf@dedasys.com>
Content-Type: text/plain
Message-Id: <1092729140.9539.129.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 17:52:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 04:38, David N. Welton wrote:
> davidw@dedasys.com (David N. Welton) writes:
> 
> > If it's useful, I suppose I can try backing of to 2.6.7 to see if it
> > suffers from the same problem...
> 
> 2.6.7 is also broken.  Fresh 2.6.7 compiled, and it doesn't work
> either.

Can you try going backward in time find when it broke ?

Ben.


