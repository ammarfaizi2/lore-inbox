Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUHKXNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUHKXNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHKXNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:13:46 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:58088 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S268321AbUHKXL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:11:28 -0400
Date: Thu, 12 Aug 2004 01:11:24 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: David Woodhouse <postmaster@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040811231124.GC14073@louise.pinerecords.com>
References: <20040811163333.GE10100@louise.pinerecords.com> <20040811175105.A30188@infradead.org> <20040811170208.GG10100@louise.pinerecords.com> <20040811181142.A30309@infradead.org> <20040811172222.GI10100@louise.pinerecords.com> <20040811184148.A30660@infradead.org> <20040811175109.GJ10100@louise.pinerecords.com> <1092264200.1438.4347.camel@imladris.demon.co.uk> <20040811225612.GB14073@louise.pinerecords.com> <1092265608.1438.4364.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092265608.1438.4364.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug-12 2004, Thu, 00:06 +0100
David Woodhouse <postmaster@infradead.org> wrote:

> On Thu, 2004-08-12 at 00:56 +0200, Tomas Szepe wrote:
> > Ok, thanks for the warning.  Is there any reason why you should
> > be trying to look up postmaster@ from the sender domain upon
> > RCPT TO?
> 
> Part of standard verification of sender addresses. You're being offered
> an email.... if you can't send a bounce to the address it claims to come
> from, or if you can't send a mail to postmaster at the same domain, then
> the chances that the mail you're being offered is a fake are high enough
> to warrant rejecting it.

Ok, I see, but wouldn't an "and" where you write "or" make more sense? :)

Anyway, I screwed up in the aliases vs. virtusertable department again.

-- 
Tomas Szepe <szepe@pinerecords.com>
