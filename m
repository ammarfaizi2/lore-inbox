Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWAFR3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWAFR3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932851AbWAFR3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:29:39 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5036 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932722AbWAFR3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:29:34 -0500
Message-ID: <43BEA8F8.8070900@pobox.com>
Date: Fri, 06 Jan 2006 12:29:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 6/7] Unlinline a bunch of other functions
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544226.2940.23.camel@laptopd505.fenrus.org>
In-Reply-To: <1136544226.2940.23.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Arjan van de Ven wrote: > Subject: uninline: misc >
	From: Arjan van de Ven <arjan@infradead.org> > > Remove the "inline"
	keyword from a bunch of big functions in the kernel > with the goal of
	shrinking it by 30kb to 40kb > > Signed-off-by: Arjan van de Ven
	<arjan@infradead.org> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Subject: uninline: misc
> From: Arjan van de Ven <arjan@infradead.org>
> 
> Remove the "inline" keyword from a bunch of big functions in the kernel
> with the goal of shrinking it by 30kb to 40kb
> 
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

ACK for drivers/net and libata

	Jeff



