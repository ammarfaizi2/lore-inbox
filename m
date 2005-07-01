Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263127AbVGAAIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbVGAAIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVGAAIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:08:54 -0400
Received: from animx.eu.org ([216.98.75.249]:58503 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S263127AbVGAAIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:08:53 -0400
Date: Thu, 30 Jun 2005 20:25:03 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] build just one driver
Message-ID: <20050701002503.GA14098@animx.eu.org>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel@vger.kernel.org
References: <200506282309.20296.gustavo@compunauta.com> <9a874849050629122775d0542c@mail.gmail.com> <Pine.LNX.4.60.0506302149500.8278@poirot.grange> <Pine.LNX.4.62.0507010053390.2858@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507010053390.2858@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> > Unfortunately, one cannot do make dir/module.ko... Would it be too 
> > difficult to add?
> 
> Hmm, I suspect people would find that useful. 
> I'm not making any promises, but I might take a look at adding that later, 
> on the other hand I don't have much time at the moment, so maybe I 
> won't...

How about a target that does only stage 2 module building?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
