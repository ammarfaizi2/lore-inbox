Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUJIAEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUJIAEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUJIAEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:04:42 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:8083 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266252AbUJIAEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:04:40 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is right for sector_t
Date: Sat, 9 Oct 2004 02:04:46 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
References: <20041008144034.EB891B557@zion.localdomain> <200410082245.39119.blaisorblade_personal@yahoo.it> <Pine.LNX.4.60.0410082221340.26699@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0410082221340.26699@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410090204.46720.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 23:57, Anton Altaparmakov wrote:
> On Fri, 8 Oct 2004, Paolo Giarrusso wrote:
> > On Friday 08 October 2004 22:11, Anton Altaparmakov wrote:
> > > On Fri, 8 Oct 2004, Andrew Morton wrote:
> > > > blaisorblade_spam@yahoo.it wrote:

> Yes I know in the kernel and on i386 it makes no difference, I said that
> already.  But on some systems it does make a difference.  I have seen it
> myself and I have had it reported. 

> Thinking about it when I said 
> architectures I possibly meant to say "other Unix flavours", I think one
> of the *BSDs was the one where I saw the difference between %L and %ll
> manifest itself.
Ok, I thought hardware archs - for other Unixes you're right.

Sorry for this and thanks for the lesson. Bye
> Sorry, it is not.  I find it somewhat strange that you choose gcc and
> glibc to say what is correct...  Ever heard of standards?!?
Yes, I heard them, I just never bought ISO standards.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
