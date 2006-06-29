Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWF2VAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWF2VAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWF2VAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:00:24 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:31128 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932623AbWF2VAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:00:23 -0400
Date: Thu, 29 Jun 2006 14:00:23 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060629210023.GA3599@tuatara.stupidest.org>
References: <200606291801.k5TI12br003227@hera.kernel.org> <20060629204206.GA3010@tuatara.stupidest.org> <20060629204527.GD13619@redhat.com> <20060629205213.GA3534@tuatara.stupidest.org> <20060629205557.GG13619@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629205557.GG13619@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 04:55:57PM -0400, Dave Jones wrote:

>  > > +       default 64BIT
>  >                   ^^^^^ ?
>  > is that right?

>
> arch/x86_64/Kconfig has ..
>
> config 64BIT
>     def_bool y
>
> so why not ?

sorry, i wasn't aware you could put tokens like that on the RHS but
yes, it seems to work just fine, so ignore me


