Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280306AbRJaRLC>; Wed, 31 Oct 2001 12:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280309AbRJaRKv>; Wed, 31 Oct 2001 12:10:51 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:15366 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280314AbRJaRJw>;
	Wed, 31 Oct 2001 12:09:52 -0500
Date: Wed, 31 Oct 2001 15:10:13 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Module Licensing?
In-Reply-To: <3BE02C94.4020007@interactivesi.com>
Message-ID: <Pine.LNX.4.33L.0110311505160.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Timur Tabi wrote:

> The fact that the open source portions and the closed source portions
> can't function on their own is irrelevant, IMHO.
>
> Please show me where in the GPL text it says that the act of compiling a
> module and loading it into memory is subject to the GPL.

That'd be paragraph 2 b)

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

... These requirements apply to the modified work as a whole.

Since your program, which happens to consist of one open
source part and one proprietary part, is partly a derived
work from the kernel source (by using kernel header files
and the inline functions in it) your whole work must be
distributed under the GPL.

> > If you wanted to provide a mixed source/binary driver that wasnt derivative
> > of the kernel (and there are lots of reasons for it) - don't GPL your
> > open source bit use something like MPL or BSD
>
> Our open source bits are GPL because they are "derived" from the kernel
> source, which is also GPL.

"open source bits" ... from "the work as a whole"  ?

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

