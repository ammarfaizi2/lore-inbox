Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVHXOJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVHXOJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 10:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVHXOJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 10:09:42 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:13090 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750985AbVHXOJl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 10:09:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZKwDEHrv9wg8Tu8zBqLnYdxNwpfzPxdQUMBUmIb9Ao6fec2L2zv/ZcQew+yh4doq05MyqiQQLJYnbUXKAdPz0yBp8c+Hvkzzb7nATlipnV3Ouq4cyx0J0zkCNwuWB7n/QYLNypZJFzPjrgEOifoTn9cf5hFxuU+xZNT2X7LUXdA=
Message-ID: <564d96fb05082407097eed2c53@mail.gmail.com>
Date: Wed, 24 Aug 2005 11:09:38 -0300
From: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
       Rafael ?vila de Esp?ndola <rafael.espindola@gmail.com>,
       linux-kernel@vger.kernel.org, itautec@las.ic.unicamp.br,
       ltc@las.ic.unicamp.br
Subject: Re: conexant modem driver for 2.6.12
In-Reply-To: <20050824073954.GE24513@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508232128.43099.rafael.espindola@gmail.com>
	 <20050824073954.GE24513@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/05, Christoph Hellwig <hch@infradead.org> wrote:
> Please don't announce propitarty drivers on lkml, thanks.
Sorry, but my intent with this drivers is to make them as free as
possible. I have ported the old driver because the only non-free files
are the .Os . The new drivers distributed by linuxant have more
restrictive licences. I would love to see the binary modules replace
by, for example, the free modulator/demodulator implemented by Fabrice
Bellard (1), but this is a much longer project.

Rafael

1:http://fabrice.bellard.free.fr/linmodem.html
