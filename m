Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSEAJYQ>; Wed, 1 May 2002 05:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSEAJYP>; Wed, 1 May 2002 05:24:15 -0400
Received: from imladris.infradead.org ([194.205.184.45]:5892 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S293076AbSEAJYP>; Wed, 1 May 2002 05:24:15 -0400
Date: Wed, 1 May 2002 10:23:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>,
        Patricia Gaughen <gone@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] discontigmem support for ia32 NUMA box against 2.4.19pre7
Message-ID: <20020501102328.B1238@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Patricia Gaughen <gone@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204300115.g3U1FQc16634@w-gaughen.des.beaverton.ibm.com> <20020430072654.B2262@infradead.org> <20020501012213.GA32767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 06:22:13PM -0700, William Lee Irwin III wrote:
> > Umm, NUMA without SMP looks rather strange to me..
> 
> It's still fully possible, though I'm not clear on whether NUMA-Q
> supports it.

It doesn't really make sense :)

Still I think it makes sense to have CONFIG_NUMAQ or whatever to depend
on CONFIG_SMP

