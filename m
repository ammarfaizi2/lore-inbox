Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTEZSbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTEZSbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:31:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19670 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261960AbTEZSbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:31:32 -0400
Date: Mon, 26 May 2003 15:42:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "David S. Miller" <davem@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gibbs@scsiguy.com,
       acme@conectiva.com.br
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <1053923112.14018.16.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.55L.0305261541320.20861@freak.distro.conectiva>
References: <1053732598.1951.13.camel@mulgrave>  <20030524064340.GA1451@alpha.home.local>
 <1053923112.14018.16.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 May 2003, David S. Miller wrote:

> On Fri, 2003-05-23 at 23:43, Willy Tarreau wrote:
> > As I said, I really hope that we'll have a quick 2.4.22 with bug fixes taken
> > as a priority. The current pre-releases are as frequent and as big as what
> > used to be full releases in the past.
>
> I really think 2.4.x development is becoming almost non-existent
> lately.
>
> It's 5 or 6 days of silence, nothing happening at all, then a flurry
> of 10 or 20 checkins and a -rc or -pre release.
>
> If Conectiva needs to task Marcelo to so much work that he can only
> really put 1 or 2 days a week into 2.4.x, this needs be rethought at
> either one end (Conectiva finding a way to give him more 2.4.x time) or
> another (Marcelo splits up the work with someone else or we simply find
> another 2.4.x maintainer).

Splitting up the work with someone is senseless, IMO. As I said before,
2.4.22-pre should be better in that aspect. In case it doesnt, I'm giving
up 2.4.x maintenance.
