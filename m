Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTGKQ4h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTGKQ4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:56:36 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:783 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264463AbTGKQzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:55:22 -0400
Date: Fri, 11 Jul 2003 18:10:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@intercode.com.au>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711181002.B28202@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@intercode.com.au>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <Mutt.LNX.4.44.0307120139570.21806-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0307120139570.21806-100000@excalibur.intercode.com.au>; from jmorris@intercode.com.au on Sat, Jul 12, 2003 at 01:43:15AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 01:43:15AM +1000, James Morris wrote:
> On Fri, 11 Jul 2003, Dave Jones wrote:
> 
> >  Use the KAME tools port on
> >   ftp://ftp.inr.ac.ru/ip-routing/iputils-ss021109-try.tar.bz2
> 
> The above is deprecated for ipsec, use the ipsec-tools stuff mentioned 
> below.

Or the OpenBSD isakpmd or Herbert's patched freeswan userland, or..

