Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTE3Ilv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTE3Ilv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:41:51 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:62926 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263455AbTE3Ilu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:41:50 -0400
Date: Fri, 30 May 2003 09:57:26 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030530085726.GA14723@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"David S. Miller" <davem@redhat.com>, chas@cmf.nrl.navy.mil,
	linux-kernel@vger.kernel.org
References: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil> <20030529.200101.118622651.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529.200101.118622651.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 08:01:01PM -0700, David S. Miller wrote:

 > BTW, can you use more consistent changeset messages?  I always
 > at least allude to what is being changed, for example I changed
 > all of your messages to be of the form:
 > 
 > 	[ATM]: Blah blah blah in HE driver.
 > 
 > This tells the reader that:
 > 
 > 1) It's an ATM change.
 > 2) It's to the HE driver.
 > 3) The change made was "Blah blah blah" :-)

I'd also add...
4) keep the first line a brief oneliner summary, as it
gets truncated when Linus generates the shortlog.
 
A number of people (self included) have adopted this
impromptu 'standard' for bk comments. Maybe it should
get documented in Documentation/BK-usage/bk-kernel-howto.txt

		Dave


