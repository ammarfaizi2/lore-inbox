Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUBZLDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 06:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUBZLDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 06:03:53 -0500
Received: from zadnik.org ([194.12.244.90]:20951 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S262766AbUBZLDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 06:03:52 -0500
Date: Thu, 26 Feb 2004 13:03:33 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Timothy Miller <miller@techsource.com>
Cc: Christer Weinigel <christer@weinigel.se>,
       Nikita Danilov <Nikita@Namesys.COM>, <root@chaos.analogic.com>,
       Rik van Riel <riel@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <403D325F.9070907@techsource.com>
Message-ID: <Pine.LNX.4.44.0402261258380.21036-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Timothy Miller wrote:

>
> I think TOE (TCP/IP stack on the ethernet card) might be one of those
> things which doesn't fit cleanly into the layered model.

Yes. More such things exist. That is why it is hard to design a good
layered model...

And I keep thinking that the right place of a TCP/IP stack is not inside
the NIC. If God designed the man this way, where he would put our brains?
;-)


