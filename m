Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264237AbTEZEML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTEZEMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:12:10 -0400
Received: from rth.ninka.net ([216.101.162.244]:52355 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264237AbTEZEMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:12:10 -0400
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, gibbs@scsiguy.com,
       acme@conectiva.com.br
In-Reply-To: <20030524064340.GA1451@alpha.home.local>
References: <1053732598.1951.13.camel@mulgrave>
	 <20030524064340.GA1451@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053923112.14018.16.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 May 2003 21:25:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-23 at 23:43, Willy Tarreau wrote:
> As I said, I really hope that we'll have a quick 2.4.22 with bug fixes taken
> as a priority. The current pre-releases are as frequent and as big as what
> used to be full releases in the past.

I really think 2.4.x development is becoming almost non-existent
lately.

It's 5 or 6 days of silence, nothing happening at all, then a flurry
of 10 or 20 checkins and a -rc or -pre release.

If Conectiva needs to task Marcelo to so much work that he can only
really put 1 or 2 days a week into 2.4.x, this needs be rethought at
either one end (Conectiva finding a way to give him more 2.4.x time) or
another (Marcelo splits up the work with someone else or we simply find
another 2.4.x maintainer).

I really want something more -ac paced although that may be too extreme
for some people. :-)

-- 
David S. Miller <davem@redhat.com>
