Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUE0T0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUE0T0B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265077AbUE0T0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:26:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58851 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265075AbUE0TZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:25:58 -0400
Date: Thu, 27 May 2004 16:27:34 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [PATCH 0/14] prism54: bring up to sync with prism54.org cvs rep
Message-ID: <20040527192733.GB14186@logos.cnet>
References: <20040524083003.GA3330@ruslug.rutgers.edu> <20040524085727.GR3330@ruslug.rutgers.edu> <40B62F29.6090101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B62F29.6090101@pobox.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 02:10:49PM -0400, Jeff Garzik wrote:
> Luis R. Rodriguez wrote:
> >BTW we can supply a 2.4 prism54 patch (as new driver). Would that be
> >wanted?
> 
> No objections here.
> 
> 2.4.x is vaguely closed, though, so Marcelo may not be interested in new 
> drivers.

IMO support for new hardware (new drivers) which dont break existing setups are fine.

Jeff, you are actively maintaining most of the network drivers in v2.4, if you are OK with the 
inclusion of this, I'm OK.

Does this make sense?
