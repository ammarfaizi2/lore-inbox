Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319048AbSIJATg>; Mon, 9 Sep 2002 20:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319049AbSIJATf>; Mon, 9 Sep 2002 20:19:35 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:17925 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S319048AbSIJATd>; Mon, 9 Sep 2002 20:19:33 -0400
Date: Tue, 10 Sep 2002 01:24:18 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 - EXPORT_SYMBOL(reparent_to_init) for module build
Message-ID: <20020910002418.GA69537@compsoc.man.ac.uk>
References: <20020909172111.A19949@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909172111.A19949@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 05:21:11PM -0700, Patrick Mansfield wrote:

> With 2.5.34, in order to build a module that calls daemonize(), I had to 
> export reparent_to_init:

I suggest you check the source of daemonize() in 2.5.34 ;)

regards
john
-- 
"This *is* Usenet, after all, where virtually every conversation that goes on
is fairly ludicrous in the first place."
	- Godwin's Law FAQ
