Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVDOCbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVDOCbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 22:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDOCbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 22:31:06 -0400
Received: from everest.sosdg.org ([66.93.203.161]:63652 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261721AbVDOCbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 22:31:04 -0400
Date: Thu, 14 Apr 2005 21:31:04 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: Allison <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: Kernel module_list
Message-ID: <20050415023104.GA27228@everest.sosdg.org>
Reply-To: coywolf@lovecn.org
References: <17d798805041413482f5a48c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d798805041413482f5a48c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 08:48:42PM +0000, Allison wrote:
> I am trying to simply print out the module names and code sizes.
> I am just learning how to rtraverse these data structures.

Just read /proc/modules

	Coywolf

> 
> Also, on what basis is the decision made whether to export a symbol or not ?
> 
> thanks,
> Allison
> 
> Arjan van de Ven wrote:
> > On Thu, 2005-04-14 at 19:53 +0000, Allison wrote:
> > > 
> > > I am trying to access the module list kernel data structure from a
> > > kernel module. If I gather correctly, module_list is the symbol that
> > > is the head pointer of this list.
> > 
> > can you explain what you want to do with this symbol ?
> > 
> > 
> > 
