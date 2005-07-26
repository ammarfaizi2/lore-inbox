Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVGZRla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVGZRla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVGZRjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:39:07 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:33165 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261967AbVGZRfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:35:42 -0400
Date: Tue, 26 Jul 2005 21:32:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Joachim Nilsson <joachim.nilsson@vmlinux.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       roms@lpg.ticalc.org
Subject: Re: RFT - gconfig fix
Message-ID: <20050726193245.GA8098@mars.ravnborg.org>
References: <20050726120841.GA27366@mars.ravnborg.org> <42E6567C.8090402@vmlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E6567C.8090402@vmlinux.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 05:27:56PM +0200, Joachim Nilsson wrote:
> Sam Ravnborg wrote:
> > Joachim - any specific reason why you ifdeffed out usage of stock Gtk icons?
> 
> Only to have a consistent look between xconfig and gconfig.

Can you please look into why it spits out a lot of erros when selecting:
Configure standard kernel features under the General ssetup menu.

I dunno if it did that before since I cannot run the stock gconfig
anymore.

And please enable the nicer icons. If for no other reason than at least to
make someone else update xconfig.

	Sam
