Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbTH3NtU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTH3NtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:49:20 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:1788 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id S261694AbTH3NtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:49:18 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Date: Sat, 30 Aug 2003 14:48:30 +0100
User-Agent: KMail/1.5.3
References: <200308281548.44803.tomasz_czaus@go2.pl> <200308301344.56545.gothick@gothick.org.uk> <20030830133509.GA686@redhat.com>
In-Reply-To: <20030830133509.GA686@redhat.com>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308301448.30810.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 Aug 2003 14:35, you wrote:
> When it was i=0 people were seeing false positives. Starting from 1
> reduces that.

Cool.  Can you point me towards any background-reading on MCE?  This's got me 
interested.

Rather ironically, since I changed my kernel back to starting from 0, I 
haven't seen any errors.  Having said that, I was only getting a couple each 
day anyway, so I'll leave it a few days and see what develops.  I think it's 
happening only once on boot, every now and again, but I've not had time to 
analyse the logs properly yet.  Maybe there's a problem when my machine's 
cold...

> in the past, Alan and myself took care of i386, Andi Kleen did AMD64.

Thanks for responding; it was fairly clear to me that I was out of my depth, 
and it's nice to know that there's someone out there that isn't *grin*

Cheers,

Matt

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
