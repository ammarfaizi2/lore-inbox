Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTE0BUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTE0BUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:20:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16332
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262547AbTE0BUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:20:17 -0400
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, gibbs@scsiguy.com,
       acme@conectiva.com.br
In-Reply-To: <1053923112.14018.16.camel@rth.ninka.net>
References: <1053732598.1951.13.camel@mulgrave>
	 <20030524064340.GA1451@alpha.home.local>
	 <1053923112.14018.16.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053995708.17151.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 01:35:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-26 at 05:25, David S. Miller wrote:
> I really want something more -ac paced although that may be too extreme
> for some people. :-)

Its up to Marcelo. If he wants to hand it on to me now 2.2 is basically
a one day a month job he can, or to someone else.

One thing I will say however - I'd have done the *same* thing as Marcelo
with aic7xxx during -rc which is to defer it. A maintainer gets a
continual stream of "completely tested utterly reliable fixes
everything" drivers, none of which prove to be so. The simple truth is
that when you give something to 10,000 users instead of 20 something
breaks. Its not that authors suck its just another testimony to the fact
computer programming is still firmly at the alchemy not the chemistry
end of its history.

If the driver works well fine, but maintainers don't have the ability to
see into the future either.

Alan

