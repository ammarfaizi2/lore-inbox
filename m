Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVE3N5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVE3N5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 09:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVE3N5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 09:57:16 -0400
Received: from main.gmane.org ([80.91.229.2]:34527 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261594AbVE3N4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 09:56:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Possible GPL Violation
Date: Mon, 30 May 2005 15:50:06 +0200
Message-ID: <yw1xis10lt69.fsf@ford.inprovide.com>
References: <1117459153.12693.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:ACgzIW4RtOLEdz6ab0MB2S1VVxM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Silva <r3pek@r3pek.homelinux.org> writes:

> Hi,
> the company that i work for is going to buy a pair of Panda
> Gatedefenders 8200 that are linux based. To start, they never told us or
> mention on their site (as far as i searched) the use of linux in their
> product. Another thing is that they don't give us root access nor any
> other type of local access to the box besides the http page the
> appliance have to be managed.

There's no requirement to give you full access to the machine.  If you
don't like that, don't buy it.

> The thing is that i asked for the kernel source they use in the
> system and they said they can't give it since they have some
> proprietary code in it, as far as i understood.

If they use some modules of their own writing, the general agreement
seems to be that they don't need to release the source code to those.
They should still give you the kernel source they used, along with any
patches they may have applied.

> I really don't know the proper way to report a GPL violation so i
> thought this was a good place.  If there is any question please feel
> free to ask, i'll do my best to answer it.

I'm having some problems myself with an STB manufacturer (Amino).  The
STB is running a Busybox/Montavista Linux of some kind, and I need to
make some changes.  To do this, they tell me I need the SDK, which is
only available under NDA, and then only after purchasing a support
contract for an ungodly number of dollars.  Somehow, I get the feeling
they are on thin ice here.

-- 
Måns Rullgård
mru@inprovide.com

