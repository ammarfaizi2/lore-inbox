Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTIRNR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTIRNR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:17:59 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:33255 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261277AbTIRNR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:17:58 -0400
Subject: Re: 2.4.23pre4 VM breaks in LTP
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309180929260.2846-100000@logos.cnet>
References: <Pine.LNX.4.44.0309180929260.2846-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1063891072.3802.4.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Sep 2003 14:17:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2003-09-18 at 13:42, Marcelo Tosatti wrote:

> Andi, about the ext3 BUG I'm waiting for Stephen. I remember he knew how
> to fix the issue but didnt had the patch ready yet sometime ago.

Different issue.  The ext3 assert failure Andi is coming up against is
something I haven't seen before, but I've sent him a debug patch to try
to find out what's behind it.

--Stephen

