Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWAISdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWAISdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWAISdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:33:20 -0500
Received: from smtp-8.smtp.ucla.edu ([169.232.47.137]:16104 "EHLO
	smtp-8.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1030234AbWAISdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:33:19 -0500
Date: Mon, 9 Jan 2006 10:33:16 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy Tarreau <willy@w.ods.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <20060108094508.GA14723@w.ods.org>
Message-ID: <Pine.LNX.4.64.0601091029190.18451@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local>
 <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org>
 <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu> <20060108094508.GA14723@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, Willy Tarreau wrote:

> Eventhough I don't like this, I would join Roberto's advice to upgrade 
> to 2.6 and stick to it. If you finally encounter the same problem on 2.6 
> after a very long time, then it would be an indication that the problem 
> is well in your hardware.

I'll keep 2.4.32 with DEBUG_SLAB up until it oopses again and will report 
that.  After, I'll probably stick with 2.6.  Thanks.

-Chris
