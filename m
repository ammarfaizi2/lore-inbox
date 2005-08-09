Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVHIJ2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVHIJ2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVHIJ2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:28:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2239 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932481AbVHIJ2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:28:15 -0400
Date: Tue, 9 Aug 2005 10:28:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@mbligh.org, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, zach@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] abstract out bits of ldt.c
Message-ID: <20050809092810.GB11397@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	mbligh@mbligh.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
	zach@vmware.com, torvalds@osdl.org
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org> <20050808113014.GA15165@elte.hu> <20050808095755.23810b15.akpm@osdl.org> <20050809092317.GA20557@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809092317.GA20557@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:23:18AM +0200, Ingo Molnar wrote:
> mine are mostly technical arguments. I just also wanted to vent away 
> this slowly gathering false notion of building 'interoperability', while 
> the only apparent goal seems to be to maximize benefits to the closed 
> hypervisors, while allowing them to not open up their code.

...

I agree completely with the points you make here, but can't find the mail
you are replying to.  Where is it coming from?

