Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319028AbSHFJOc>; Tue, 6 Aug 2002 05:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319029AbSHFJOc>; Tue, 6 Aug 2002 05:14:32 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:21000 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319028AbSHFJOb>; Tue, 6 Aug 2002 05:14:31 -0400
Date: Tue, 6 Aug 2002 10:18:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Aron Zeh <ARZEH@de.ibm.com>
Subject: Re: [PATCH] 18/18 scsi core changes
Message-ID: <20020806101807.A16350@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, Aron Zeh <ARZEH@de.ibm.com>
References: <200208051830.50713.arndb@de.ibm.com> <200208052008.35187.arndb@de.ibm.com> <20020805181234.B16035@infradead.org> <200208061306.03627.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208061306.03627.arnd@bergmann-dalldorf.de>; from arnd@bergmann-dalldorf.de on Tue, Aug 06, 2002 at 01:06:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 01:06:03PM +0200, Arnd Bergmann wrote:
> Still, it's the stuff IBM recommends for use and it's not going
> away (at least not in 2.4), so I guess it might just as well be 
> included.

Following that argumentation we could also include the broken qlogic driver
and the nvidia glue..

