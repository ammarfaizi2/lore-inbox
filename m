Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSJHWXu>; Tue, 8 Oct 2002 18:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJHWW7>; Tue, 8 Oct 2002 18:22:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19112 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261641AbSJHWWV>;
	Tue, 8 Oct 2002 18:22:21 -0400
Date: Tue, 08 Oct 2002 15:20:56 -0700 (PDT)
Message-Id: <20021008.152056.122223929.davem@redhat.com>
To: davej@codemonkey.org.uk
Cc: dwmw2@infradead.org, skip.ford@verizon.net, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021008222444.GB12379@suse.de>
References: <8973.1034111628@passion.cambridge.redhat.com>
	<18079.1034115320@passion.cambridge.redhat.com>
	<20021008222444.GB12379@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@codemonkey.org.uk>
   Date: Tue, 8 Oct 2002 23:24:44 +0100

   On Tue, Oct 08, 2002 at 11:15:20PM +0100, David Woodhouse wrote:
   
    > How about
    >  bk-commits-head
    >  bk-commits-2.4
    > 
    > then later bk-commits-2.6 etc...
   
   How about 'stable' and 'devel', then we won't have to worry
   about renaming/resubscribing when we switch revisions.

I expect people to maintain 2.4.x even when 2.6.x is
"stable" even once 2.7.x has begun.

Therefore, I like your first idea the best.

Ok?
