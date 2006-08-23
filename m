Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWHWUU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWHWUU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 16:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWHWUU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 16:20:58 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:22978 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S965162AbWHWUU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 16:20:58 -0400
Date: Wed, 23 Aug 2006 13:04:42 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Message-ID: <20060823200442.GE2084@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com> <20060823152831.GC32725@infradead.org> <20060823155715.GA5204@martell.zuzino.mipt.ru> <20060823160458.GA17712@infradead.org> <20060823115857.89f8d47b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823115857.89f8d47b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
On Wed, Aug 23, 2006 at 11:58:57AM -0700, Andrew Morton wrote:
> On Wed, 23 Aug 2006 17:04:58 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > Padding with zeros makes it even more useful:
> > > 
> > > 	[PATCH 00/17]
> > > 	[PATCH 01/17]
> > > 		...
> > > 	[PATCH 17/17]
> > 
> > To be honest I utterly hate that convention
> 
> It's so they'll correctly alphasort at the recipient's end.

That makes sense, I'll fix that in my next patch.

-- 

-Stephane
