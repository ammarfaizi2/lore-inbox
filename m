Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTEPGcr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 02:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTEPGcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 02:32:46 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.93.67.82]:22964 "EHLO
	ms-smtp-01.southeast.rr.com") by vger.kernel.org with ESMTP
	id S264324AbTEPGcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 02:32:45 -0400
From: Boris Kurktchiev <techstuff@gmx.net>
Reply-To: techstuff@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Re: The kernel is miscalculating my RAM...
Date: Fri, 16 May 2003 02:50:36 -0400
User-Agent: KMail/1.5.1
References: <200305131415.37244.techstuff@gmx.net> <200305160003.25262.techstuff@gmx.net> <3EC47A57.30407@nortelnetworks.com>
In-Reply-To: <3EC47A57.30407@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305160250.36764.techstuff@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 16 2003 1:42 am, Chris Friesen wrote:
> Boris Kurktchiev wrote:
> > ok here is what dmesg shows:
> > 384MB LOWMEM available.
> >
> > then further down:
> > Memory: 385584k/393216k available
> >
> > now how is the little 38.../39... possible?
>
> 384 * 1024 * 1000 = 393216000
blah someone already answered my question about the missing 7mbs... is there a 
doc that tell swhy the kernel reserves that much memory?
