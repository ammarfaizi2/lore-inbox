Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312401AbSDJI4C>; Wed, 10 Apr 2002 04:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSDJI4B>; Wed, 10 Apr 2002 04:56:01 -0400
Received: from imladris.infradead.org ([194.205.184.45]:36364 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312401AbSDJI4B>; Wed, 10 Apr 2002 04:56:01 -0400
Date: Wed, 10 Apr 2002 09:55:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Aviv Shavit <avivshavit@yahoo.com>, Ken Brownfield <brownfld@irridia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap - it's really unusable]
Message-ID: <20020410095555.A9568@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Aviv Shavit <avivshavit@yahoo.com>,
	Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020225224050.D26077@asooo.flowerfire.com> <20020409204545.11251.qmail@web13205.mail.yahoo.com> <20020410013609.A6875@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 01:36:09AM +0200, Andrea Arcangeli wrote:
> I recommend everybody to never use a 2.4 kernel without first applying
> this vm patch:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/vm-33.gz
> 
> It applies cleanly to both 2.4.19pre5 and 2.4.19pre6. Andrew splitted it
> into orthogonal pieces for easy merging from Marcelo's side (modulo
> -rest that is important too but that it's still quite monolithic, but
> it's pointless to invest further effort at this time until we are
> certain Marcelo will do its job and eventually merge it in mainline):

Maybe you could start by explaining the questions asked by akpm ontop of
many of the split pages that you even merged into -aa?  Or by explaining why
you reverse all functional changes akpm did in the -rest patch?

