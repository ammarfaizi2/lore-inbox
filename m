Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267981AbTGLRXy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbTGLRXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 13:23:54 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:40714 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S267981AbTGLRXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 13:23:53 -0400
Date: Sun, 13 Jul 2003 03:38:16 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Christoph Hellwig <hch@infradead.org>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
In-Reply-To: <20030711181002.B28202@infradead.org>
Message-ID: <Mutt.LNX.4.44.0307130337120.25105-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jul 2003, Christoph Hellwig wrote:

> On Sat, Jul 12, 2003 at 01:43:15AM +1000, James Morris wrote:
> > On Fri, 11 Jul 2003, Dave Jones wrote:
> > 
> > >  Use the KAME tools port on
> > >   ftp://ftp.inr.ac.ru/ip-routing/iputils-ss021109-try.tar.bz2
> > 
> > The above is deprecated for ipsec, use the ipsec-tools stuff mentioned 
> > below.
> 
> Or the OpenBSD isakpmd or Herbert's patched freeswan userland, or..

Yes, but I meant specifically the ipsec tools (e.g. setkey) which were 
initially in iptuils, can now be found updated and maintained in 
ipsec-tools.


- James
-- 
James Morris
<jmorris@intercode.com.au>

