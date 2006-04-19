Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWDSSPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWDSSPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWDSSPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:15:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:63904 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750943AbWDSSPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:15:09 -0400
Date: Wed, 19 Apr 2006 11:10:45 -0700
From: Tony Jones <tonyj@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 1/11] security: AppArmor - Integrate into kbuild
Message-ID: <20060419181045.GA29674@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419174913.29149.55209.sendpatchset@ermintrude.int.wirex.com> <1145469439.3085.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145469439.3085.68.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 07:57:19PM +0200, Arjan van de Ven wrote:
> On Wed, 2006-04-19 at 10:49 -0700, Tony Jones wrote:
> > This patch glues AppArmor into the security configuration and Makefile.
> > It also creates the AppArmor configuration and Makefile.
> 
> 
> please use a "proper" patch ordering; it's not possible to apply this
> patch only and get a building kernel, breaking bisection

Fair enough, sorry. If we repost I will make sure I do this.
