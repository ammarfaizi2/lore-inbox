Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271223AbTHRFgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 01:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271230AbTHRFgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 01:36:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43753 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271223AbTHRFgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 01:36:37 -0400
Date: Sun, 17 Aug 2003 22:29:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: alan@lxorguk.ukuu.org.uk, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030817222943.2fdf9765.davem@redhat.com>
In-Reply-To: <200308171555280781.0067FB36@192.168.128.16>
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
	<20030728213933.F81299@coredump.scriptkiddie.org>
	<200308171509570955.003E4FEC@192.168.128.16>
	<200308171516090038.0043F977@192.168.128.16>
	<1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	<200308171555280781.0067FB36@192.168.128.16>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 15:55:28 +0200
"Carlos Velasco" <carlosev@newipnet.com> wrote:

> And you can just use other OS and solve the problem

Nobody hacking on Linux feels threatened by this.

And if anything, it's the last thing that would make us change Linux
to behave one way or another.  That would be a stupid reason to make a
change to the kernel, just because someone is shitting their pants on
some mailing list endlessly about it.

So please, go ahead, go use another OS if that suits your needs
better, it certainly has no bearing on how we'll make Linux's ARP
behave.

But the one thing you can't do is accuse us of not providing the
facility you need.  Your only valid complaint is that the facility
doesn't get configured in the way that you would like it to, and
frankly my answer to that is "tough".
