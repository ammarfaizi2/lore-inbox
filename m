Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVCDAKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVCDAKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVCDAIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:08:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50527
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262741AbVCCXpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:45:31 -0500
Date: Fri, 4 Mar 2005 00:45:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, jgarzik@pobox.com, torvalds@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303234523.GS8880@opteron.random>
References: <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com> <20050303151752.00527ae7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303151752.00527ae7.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 03:17:52PM -0800, Andrew Morton wrote:
> That's the only way it _can_ work.  The maintainer of 2.6.x.y shouldn't be

Andrew, what about my suggestion of shifting left x.y of 8 bits? ;) Do
we risk the magic 2.7 number to get us stuck in unstable mode for 2
years instead of 2 months? Doesn't 2.6.x.y pose the same risk but
by also breaking the numbering and the stable kernel identification for
no good reason? (ignoring the "2.6." part that carries no useful info
anymore ;)
