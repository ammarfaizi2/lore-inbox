Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269166AbUIHNwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbUIHNwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUIHNsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:48:41 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:4872 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267928AbUIHNsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:48:03 -0400
Date: Wed, 8 Sep 2004 14:47:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>, Andrey Panin <pazke@donpac.ru>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908144755.A32156@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Scott Wood <scott@timesys.com>, Andrey Panin <pazke@donpac.ru>
References: <20040908120613.GA16916@elte.hu> <413EFB11.2000507@timesys.com> <20040908142529.A31922@infradead.org> <20040908134032.GA24201@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908134032.GA24201@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 03:40:32PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 03:40:32PM +0200, Ingo Molnar wrote:
> 
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Wed, Sep 08, 2004 at 08:29:05AM -0400, La Monte H.P. Yarroll wrote:
> > > In the interests of full provinence, the TimeSys patches are based on
> > > work by Andrey Panin.
> > 
> > Btw, Andrey's patches got all the things right I complained about :)
> 
> do you mean the irq and softirq threading patches?

No, irq.c consolidation.
