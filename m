Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271784AbRHUS3L>; Tue, 21 Aug 2001 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271783AbRHUS3B>; Tue, 21 Aug 2001 14:29:01 -0400
Received: from www.transvirtual.com ([206.14.214.140]:52497 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S271782AbRHUS24>; Tue, 21 Aug 2001 14:28:56 -0400
Date: Tue, 21 Aug 2001 11:28:57 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Stephen Satchell <satch@fluent-access.com>, linux-kernel@vger.kernel.org
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
In-Reply-To: <Pine.LNX.4.33.0108211413080.14374-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.10.10108211126380.20205-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As for the kernel, it needs a few improvements during 2.5: I plan to submit a
> patch that replaces much of the existing pc keyboard/mouse code with state
> machine driven code that doesn't block interrupts out for long periods of
> time, as well as fixing a few of the lockup issues the current driver has.

Their already is a replacement driver using the input api avaliable that I
was planning to intergrate into 2.5. It fixed alot of the issues people
are having now.  

