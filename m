Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWIKTsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWIKTsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWIKTsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:48:25 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:51395 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1751349AbWIKTsY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:48:24 -0400
From: Oliver Neukum <oliver@neukum.org>
To: paulmck@us.ibm.com
Subject: Re: Uses for memory barriers
Date: Mon, 11 Sep 2006 21:48:42 +0200
User-Agent: KMail/1.8
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <200609090049.20416.oliver@neukum.org> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> <20060911162059.GA1496@us.ibm.com>
In-Reply-To: <20060911162059.GA1496@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609112148.42302.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. September 2006 18:21 schrieb Paul E. McKenney:
> 1.      A given CPU will always perceive its own memory operations
>         as occuring in program order.

Is this true for physical memory if virtually indexed caches are
involved?

	Regards
		Oliver
