Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbTDEIJV (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 03:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTDEIJV (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 03:09:21 -0500
Received: from main.gmane.org ([80.91.224.249]:48615 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261945AbTDEIJU (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 03:09:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@iki.fi>
Subject: RE: Promise TX4 100: neither IDE port enabled
Date: Sat, 05 Apr 2003 02:58:40 +0300
Message-ID: <b6l5pr$ogm$1@main.gmane.org>
References: <73300040777B0F44B8CE29C87A0782E101FA98E9@exchange.explainerdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Vardy wrote:

>> Without knowing the cause or fix for it I instead run ac-patches.
>> The card(s) are than configured correctly.
>> I now run 2.4.21pre5ac3 and I remember 2.4.21pre4ac4 also worked fine.
> 
> I tried 2.4.21-pre5-ac3 but still I get the same problems, with what
> settings did you compile the kernel?
> 
> I used these:
> 
> On:  PROMISE PDC202{46|62|65|67} support
> On:  Special UDMA Feature
> On:  PROMISE PDC202{68|69|70|71|75|76|77} support
> 
> Off: Special FastTrak Feature

Switch this on and it should work ...

Thomas

