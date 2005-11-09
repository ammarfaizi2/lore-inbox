Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVKIQ6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVKIQ6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVKIQ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:58:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:17376 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932136AbVKIQ6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:58:10 -0500
Date: Wed, 9 Nov 2005 08:57:43 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/39] NLKD - an alternative kallsyms approach
Message-ID: <20051109165743.GE32068@kroah.com>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511090847590.4001@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511090847590.4001@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 08:50:15AM -0800, Randy.Dunlap wrote:
> BTW, are you posting these just for comments or did you want
> someone to apply/merge them?  If so, who?  You should send them
> to that someone (unless you have some other arrangements) --
> at least that's the normal procedure.

And the documented one too, see Documentation/SubmittingPatches, section
5.

Why does no one ever read the documentation...

greg k-h
