Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKBZC>; Wed, 10 Jan 2001 20:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAKBYw>; Wed, 10 Jan 2001 20:24:52 -0500
Received: from uucp.gnuu.de ([151.189.0.84]:27912 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id <S129431AbRAKBYm>;
	Wed, 10 Jan 2001 20:24:42 -0500
Date: Thu, 11 Jan 2001 02:23:21 +0100
From: Ulrich Schwarz <uschwarz@gmx.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 vm BUG (ksymoopsed)
Message-ID: <20010111022321.A4067@fruli.2y.net>
In-Reply-To: <20010111011328.A2945@fruli.2y.net> <Pine.LNX.4.21.0101102121141.8803-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101102121141.8803-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Jan 10, 2001 at 09:21:57PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 09:21:57PM -0200, Marcelo Tosatti wrote:

>> kernel BUG at vmscan.c:452!
>> invalid operand: 0000

> Does reiserfs patch changes vmscan.c ?

No, it doesn't.

It's strange that the console reported vmscan.c:452 whilst
kern.log reports page_alloc.c:74

So long.
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
