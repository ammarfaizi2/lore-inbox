Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWJ2Px4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWJ2Px4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWJ2Px4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:53:56 -0500
Received: from web32405.mail.mud.yahoo.com ([68.142.207.198]:6499 "HELO
	web32405.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751751AbWJ2Pxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:53:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jfX4jKk1TQYBAAjCff8TfIEULmyQhudZOmV+905XpKbbWapbxtWuovDZov0ADAvtIM5XF6Dt7LcIfzyVHODkugclF58Av9kUW9PtOXwGCaM+6YLuJz5kn3LjYHR4S/Yh1rsO3P2RC76FXFPpBnTRwEp9uQ7E0+bH4E4u6cdi/4Y=  ;
Message-ID: <20061029155354.12118.qmail@web32405.mail.mud.yahoo.com>
Date: Sun, 29 Oct 2006 07:53:54 -0800 (PST)
From: Giridhar Pemmasani <pgiri@yahoo.com>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4544C709.6070305@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Martin J. Bligh" <mbligh@google.com> wrote:

> Thanks for the patch ... but more worrying is how this got broken.
> Wasn't the point of having the -mm tree that patches like this went
> through it for testing, and we avoid breaking mainline? especially
> this late in the -rc cycle.

I don't know how it got into Linus's tree, but the breakage was due to my
earlier patch - sorry.

Giri


 
____________________________________________________________________________________
Get your email and see which of your friends are online - Right on the New Yahoo.com 
(http://www.yahoo.com/preview) 

