Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUFTLij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUFTLij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUFTLij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 07:38:39 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:44771 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265398AbUFTLig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 07:38:36 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andi Kleen <ak@suse.de>
Subject: Re: Opteron bug
Date: Sun, 20 Jun 2004 13:47:17 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <200406192229.14296.rjwysocki@sisk.pl> <20040620152256.4a173a95.ak@suse.de>
In-Reply-To: <20040620152256.4a173a95.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406201347.17967.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 of June 2004 15:22, Andi Kleen wrote:
> On Sat, 19 Jun 2004 22:29:14 +0200
>
> "R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
> > Hi,
> >
> > I hope everyone interested in the development for Opteron is aware of the
> > bug described here:
> >
> > http://www.3dchips.net/content/story.php?id=3927
>
> The kernel never uses backwards REP prefixes.

So it doesn't matter. :-)

Well, is there any case in which the gcc can produce such stuff?

rjw

