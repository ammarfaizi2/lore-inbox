Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318587AbSHAC1l>; Wed, 31 Jul 2002 22:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318588AbSHAC1l>; Wed, 31 Jul 2002 22:27:41 -0400
Received: from [209.237.59.50] ([209.237.59.50]:27364 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S318587AbSHAC1k>; Wed, 31 Jul 2002 22:27:40 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
References: <200208010156.g711uMc340112@saturn.cs.uml.edu>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 31 Jul 2002 19:30:59 -0700
In-Reply-To: <200208010156.g711uMc340112@saturn.cs.uml.edu>
Message-ID: <52vg6vwbrw.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Albert" == Albert D Cahalan <acahalan@cs.uml.edu> writes:

    Guillaume> Definitely 2.7:
    Guillaume> o InfiniBand support

    Albert> Why?

    Albert> Sure, one could get fancy, but just running SCSI or IP
    Albert> over InfiniBand can't be that complicated... hmmm?

Look at http://infiniband.sf.net to see all the infrastructure
required just to get to the point of being able to start to write an
IP-over-IB driver.

Best,
  Roland
