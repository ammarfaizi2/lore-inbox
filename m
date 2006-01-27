Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWA0VoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWA0VoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWA0VoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:44:17 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:41433 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932505AbWA0VoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:44:16 -0500
Date: Fri, 27 Jan 2006 21:45:40 +0000
From: ed <ed@ednevitible.co.uk>
To: linux-kernel@vger.kernel.org
Subject: OT: Re: traceroute bug ?
Message-ID: <20060127214540.110ca18b@workstation>
In-Reply-To: <9a8748490601271057y709d3501ob278c85b104eef57@mail.gmail.com>
References: <000601c62370$db00cd50$1701a8c0@gerold>
	<9a8748490601271057y709d3501ob278c85b104eef57@mail.gmail.com>
Organization: the triads
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-Face: =\=1ht]b*gboJ:&+:3x1vGz}fCe40TZJ9s@L2~YGi}]c(fY-_7J]wUR.6MSH\oeq#@H6aAERh(<<1miWJ|x/-1g`r3EmzY3FE?VxmEih9%ETmPd7zChR1"zWC$iuK{|{R+Ss{I3w(KC"_LM%S!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006 19:57:38 +0100
Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On 1/27/06, Gerold van Dijk <gerold@sicon-sr.com> wrote:
> > Why can I NOT do a traceroute specifically within my own
> > (sub)network
> >
> > 207.253.5.64/27
> >
> > with any distribution of Linux??

> Because you configured your machines to drop icmp packets perhaps.
> Some router on your network may be dropping icmp packets.

I've known some bridging devices have filter rules too.

-- 
Regards, Ed http://www.usenix.org.uk
:%s/Open Source/Free Software/g
