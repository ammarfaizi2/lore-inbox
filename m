Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSLZG1M>; Thu, 26 Dec 2002 01:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSLZG1M>; Thu, 26 Dec 2002 01:27:12 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:24329 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S262472AbSLZG1L>; Thu, 26 Dec 2002 01:27:11 -0500
Date: Wed, 25 Dec 2002 22:35:16 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
cc: "'Billy Rose'" <billyrose@billyrose.net>, <bp@dynastytech.com>,
       <linux-kernel@vger.kernel.org>, <felipewd@terra.com.br>
Subject: RE: CPU failures ... or something else ?
In-Reply-To: <001d01c2aca5$dd35ff40$b9293a41@joe>
Message-ID: <20021225223454.I64865-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, that's the thing - I _didn't_ switch cpus.  Sometimes the error is
cpu 0, sometimes it is cpu 1.



On Thu, 26 Dec 2002, Joseph D. Wagner wrote:

> > usually it says proc #1 in the error, but
> > the first time it said proc #0 - is that
> > interesting ?
>
> proc 0 and proc 1 are CPU 0 and CPU 1, respectively.  If you switched CPU's
> and now the error is on the other proc, then it IS a CPU error.
>
> Joseph Wagner
>
> P.S.  In hindsight, I probably should have read the entire thread before
> responding.  8-)  You live you learn.
>
> Joseph Wagner
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

