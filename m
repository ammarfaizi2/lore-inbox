Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUI2Rp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUI2Rp1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268742AbUI2Rp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:45:27 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:50948 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268751AbUI2RpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:45:22 -0400
Date: Wed, 29 Sep 2004 18:45:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@novell.com>,
       Ankit Jain <ankitjain1580@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: processor affinity
Message-ID: <20040929184510.A15692@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Jeff V. Merkey" <jmerkey@drdos.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@novell.com>,
	Ankit Jain <ankitjain1580@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com> <41596F7F.1000905@drdos.com> <1096387088.4911.4.camel@betsy.boston.ximian.com> <41598B23.50702@drdos.com> <1096408318.13983.47.camel@localhost.localdomain> <415AE953.3070105@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <415AE953.3070105@drdos.com>; from jmerkey@drdos.com on Wed, Sep 29, 2004 at 10:56:51AM -0600
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 10:56:51AM -0600, Jeff V. Merkey wrote:
> Using them for Intel Cache affinity was new at the time.  Intel SMP 
> hardware was not readily available at the time and was in
> its infancy in 1993 when this was developed.  This implementation (like 
> Linux) was specific to IA32 architecture systems. 

The Linux implementation works on about a dozen plattforms, or how
many smp ports we have these days..

