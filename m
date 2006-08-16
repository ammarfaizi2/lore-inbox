Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWHPE3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWHPE3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 00:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWHPE3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 00:29:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19882 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750737AbWHPE3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 00:29:31 -0400
Date: Wed, 16 Aug 2006 00:29:24 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060816042924.GA30115@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Robert Hancock <hancockr@shaw.ca>,
	linux-kernel@vger.kernel.org
References: <fa.nURugTWtyfQKAbvUB0DbTkmyPAY@ifi.uio.no> <44E28989.1010904@shaw.ca> <20060815212656.4eb260f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815212656.4eb260f3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:26:56PM -0700, Andrew Morton wrote:
 > On Tue, 15 Aug 2006 20:57:13 -0600
 > Robert Hancock <hancockr@shaw.ca> wrote:
 > 
 > > Andrew Morton wrote:
 > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
 > > 
 > > Warnings and an oops on suspend to disk:
 > > 
 > > http://www.roberthancock.com/oops1.jpg
 > > http://www.roberthancock.com/oops2.jpg
 > > http://www.roberthancock.com/oops3.jpg
 > > http://www.roberthancock.com/oops4.jpg
 > > http://www.roberthancock.com/oops5.jpg
 > > http://www.roberthancock.com/oops6.jpg
 > > http://www.roberthancock.com/oops7.jpg
 > > http://www.roberthancock.com/oops8.jpg
 > > 
 > > Sleeping function called from invalid context in acpi
 > 
 > Yes.  It appears that we've decided to release 2.6.18 with this feature.

Well it's not like it'd be a regression. That thing has been there
for over a year now at least in one form or other.

		Dave

-- 
http://www.codemonkey.org.uk
