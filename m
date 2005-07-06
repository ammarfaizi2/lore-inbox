Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVGFGDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVGFGDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVGFGAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:00:30 -0400
Received: from harddata.com ([216.123.194.198]:59558 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id S261716AbVGFEiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 00:38:04 -0400
Date: Tue, 5 Jul 2005 22:37:43 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Greg KH <greg@kroah.com>
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
Message-ID: <20050705223743.A28905@mail.harddata.com>
References: <20050703171202.A7210@mail.harddata.com> <20050704054441.GA19936@kroah.com> <1120600243.27600.75.camel@localhost> <20050705215739.GA2635@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050705215739.GA2635@kroah.com>; from greg@kroah.com on Tue, Jul 05, 2005 at 02:57:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 02:57:40PM -0700, Greg KH wrote:
> On Tue, Jul 05, 2005 at 03:50:43PM -0600, Zan Lynx wrote:
> > Sourced from here:
> > http://hulllug.principalhosting.net/archive/index.php/t-52440.html
> 
> No, that is not the same topic or thread.

Formally you are correct but from my POV this sounds casuistic and
fit for a patent lawyer.  You were "recently advised not to change
these symbols" and you stated that you will not. So instead you did
an end run and you removed an old interface and introduced a
replacement; but this time with EXPORT_SYMBOL_GPL - which has the
same effect as what you told you will not do.

> If you know of any closed source code, using those functions, please put
> them in contact with me.

Well, I gave an example in my original question.  Yes, I asked them
to contact you.  If they will do that I have no idea.

   Michal
