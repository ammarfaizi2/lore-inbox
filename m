Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVLFCqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVLFCqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVLFCqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:46:16 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:18100 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751356AbVLFCqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:46:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=LhJjHy4fJa3E/PPo2rDpy3OVBO102Z3jFcTuaJDGp95zIkygxSGYuSdSKHGCFZJQ1BsR5DlICSxzNKIMebtrXh2RE46fSdT5a8TscTTgewDgzR7+f+dMynV1C6GxS4CY7daCEwz+usqKVfTlv/4/u2DyVMcYmtmULOQYbJltmAY=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 00/43] ktimer reworked
Date: Mon, 5 Dec 2005 21:46:01 -0500
User-Agent: KMail/1.8.3
Cc: Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, ray-gmail@madrabbit.org,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <200512032028.59472.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <Pine.LNX.4.61.0512051136060.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0512051136060.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512052146.03041.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 14:40, Roman Zippel wrote:
> ...
> rbtree based timer are also not necessarily the better general case. ...

... As you've mentioned before. Somehow I missed that. Thank you for your
patience.

Andrew
