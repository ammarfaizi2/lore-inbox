Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbSJHWSw>; Tue, 8 Oct 2002 18:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbSJHWSX>; Tue, 8 Oct 2002 18:18:23 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:50904 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261526AbSJHWRU>;
	Tue, 8 Oct 2002 18:17:20 -0400
Date: Tue, 8 Oct 2002 23:24:44 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, skip.ford@verizon.net,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021008222444.GB12379@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@redhat.com>, skip.ford@verizon.net,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <20021008.150444.118305428.davem@redhat.com> <200210060846.g968klWf000632@pool-141-150-241-241.delv.east.verizon.net> <3D9FFD21.8040404@pobox.com> <8973.1034111628@passion.cambridge.redhat.com> <18079.1034115320@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18079.1034115320@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 11:15:20PM +0100, David Woodhouse wrote:

 > >  Should we have two lists, one for 2.4 and one for 2.5?
 > > I'll set it up once decided.
 > 
 > Probably one for each. We could add headers which say which branch it is 
 > but that's still a lot of extra traffic for subscribers who only want the 
 > stable branch info and will filter the 2.5 ones to /dev/null.
 > 
 > How about
 >  bk-commits-head
 >  bk-commits-2.4
 > 
 > then later bk-commits-2.6 etc...

How about 'stable' and 'devel', then we won't have to worry
about renaming/resubscribing when we switch revisions.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
