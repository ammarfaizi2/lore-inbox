Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFNVVo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 17:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbTFNVVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 17:21:44 -0400
Received: from smtp.terra.es ([213.4.129.129]:63188 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id S261151AbTFNVVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 17:21:43 -0400
Date: Sat, 14 Jun 2003 23:35:27 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-Id: <20030614233527.08831e2a.diegocg@teleline.es>
In-Reply-To: <20030613182924.A32241@infradead.org>
References: <200306131453.h5DErX47015940@hera.kernel.org>
	<20030613165628.GE28609@in-ws-001.cid-net.de>
	<20030613172226.GB9339@merlin.emma.line.org>
	<20030613182924.A32241@infradead.org>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003 18:29:24 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Jun 13, 2003 at 07:22:26PM +0200, Matthias Andree wrote:
> > I'd add "XFS merge" to the list:
> 
> I'll start feeding the few remaining core changes to Marcelo now,
> the actual filesystem then is just yet another driver that could
> be merged any time :)

Just a small suggestion: Why not ALSA?
I mean, 2.5 is there for new things, indeed. But alsa are drivers (ie: it
shouldnt affect core code and you haven't to use them if you don't want) ,
and after all it's one of those things that lots of people have to add (a
lot of times manually and lots of people doesn't want to know how to patch
a kernel; although all distros ship it).

In some cases, alsa gives you decent sound (in the case of my sound card,
which is both supported by oss and alsa). Other times, you've not a choice.

And although it's not perfect code, and it has bugs, i bet the alsa people
wouldn't mind to help to solve them.

I'm not saying we should merge 2.5 changes in 2.4 but...


Just a very hume and small suggestion :)
