Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946993AbWKKHPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946993AbWKKHPu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 02:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947129AbWKKHPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 02:15:50 -0500
Received: from 1wt.eu ([62.212.114.60]:12037 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1946993AbWKKHPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 02:15:50 -0500
Date: Sat, 11 Nov 2006 08:15:33 +0100
From: Willy Tarreau <w@1wt.eu>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-ID: <20061111071533.GA577@1wt.eu>
References: <200611090757.48744.a1426z@gawab.com> <20061109090502.4d5cd8ef@freekitty> <200611101852.14715.a1426z@gawab.com> <9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com> <4554AC12.6040407@osdl.org> <20061110085311.54fd65f2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110085311.54fd65f2.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 08:53:11AM -0800, Randy Dunlap wrote:
> Either that or lkml is/remains for bug reporting and we move development
> somewhere else.  Or my [repeated] preference:
> 
> do development on specific mailing lists (although there would
> likely need to be a fallback list when it's not clear which mailing
> list should be used)

I've been thinking about this too for a while now. There is something
like half of the email volume which are (semi-)automated emails
containing patches moving from a GIT tree to another. I think that
moving this to some linux-dev or something like this would :

  1) reduce the noise on LKML so that problem reports are better caught
  2) reduce the global email volume because instead of sending all these
     emails to 10-20000 persons(?), only maybe a thousand will be subscribed.
  3) reduce even more the latency between post and publication due to 2.

I don't know if others would be interested, in which case it would be wise
to poll on the subject and include Matti and Davem to the discussion.

Regards,
Willy

