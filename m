Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbTIEVKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbTIEVKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:10:25 -0400
Received: from codepoet.org ([166.70.99.138]:54486 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S266154AbTIEVKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:10:22 -0400
Date: Fri, 5 Sep 2003 15:10:23 -0600
From: Erik Andersen <andersen@codepoet.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel header separation
Message-ID: <20030905211022.GA16993@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk> <20030903014908.GB1601@codepoet.org> <1062772560.32473.25.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062772560.32473.25.camel@hades.cambridge.redhat.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 05, 2003 at 03:36:01PM +0100, David Woodhouse wrote:
> On Tue, 2003-09-02 at 19:49 -0600, Erik Andersen wrote:
> > Header files intended for use by users should probably drop
> > linux/types.h just include <stdint.h>,,,  Then convert the 
> > types over to ISO C99 types.
> 
> Yes. Absolutely. In fact, we should do the rest of the kernel with as
> much fervour as we've been changing struct initialisers... but at least
> the user headers would be a good start.

Absolutely!!!

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
