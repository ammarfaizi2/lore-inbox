Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTA3Lci>; Thu, 30 Jan 2003 06:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTA3Lci>; Thu, 30 Jan 2003 06:32:38 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:17935 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267494AbTA3Lch>; Thu, 30 Jan 2003 06:32:37 -0500
Date: Thu, 30 Jan 2003 11:42:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, linux-visws-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-visws-devel] Re: [PATCH] visws support for 2.5.59
Message-ID: <20030130114200.A26721@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-visws-devel@lists.sf.net, linux-kernel@vger.kernel.org
References: <20030127074644.GB4648@pazke> <20030130085457.A23075@infradead.org> <20030130112650.GA497@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030130112650.GA497@pazke>; from pazke@orbita1.ru on Thu, Jan 30, 2003 at 02:26:50PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 02:26:50PM +0300, Andrey Panin wrote:
> Probably agreed. But I didn't even try to compile UP kernels for visws.
> Added into todo list.

Then either test it or add a comment explaining why it's disallowed

> The visws support is totally borken now, so why submit this ASAP ?

the visw fb driver can't work anyway, so there's no harm if you get this
driver update into James' tree (an he'll submit it to Linus with the other
fb stuff) soon, but your patch will get a lot smaller and easier to integrate.

> This varibable-like macro replaces two #ifndef's in smp.c and smpboot.c
> I'm not sure are the really necessary and I can't test it because my visws
> has one cpu only (and it's impossible to buy VRM and slot-1 P3 in Russia).

I can try to get one or two for you in a second hand store here in Germany
for you.  sending it to russia will probably be more important than the
actual price for them :)

