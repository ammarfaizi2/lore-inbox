Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTLBTzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTLBTzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:55:09 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:50577 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S264331AbTLBTzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:55:04 -0500
X-Sender-Authentication: net64
Date: Tue, 2 Dec 2003 20:55:02 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: nathans@sgi.com, lm@work.bitmover.com, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
Message-Id: <20031202205502.474755f3.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet>
References: <20031202002347.GD621@frodo>
	<Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Dec 2003 09:22:48 -0200 (BRST)
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> [...]
> A development tree is much different from a stable tree. You cant just
> simply backport generic VFS changes just because everybody agreed with
> them on the development tree.
> 
> My whole point is "2.6 is almost out of the door and its so much better".  
> Its much faster, much cleaner. 

Even if I am a bit off-topic here, please reconsider your last sentence. Don't
make people think that 2.6 is in a widely useable state right now. Just take a
look at the history of 2.4. Don't forget 2.4 can be used in boxes beyond 4 GB
only right _now_ (2.4.23), all previous versions fall completely apart on i386
platform. 2.4 is right now nice, useable and pretty stable - and 2.6 has not
even begun to see the real-and-ugly world yet. There will for sure be a lot of
interesting test cases during the next months for 2.6, but there are quite an
amount of people that need a real stable environment - and that's why they will
have to use 2.4 for at least one year from now on.

This is no vote for or against XFS-inclusion, I don't know the thing at all. I
only want to state: developer environment is pretty different from the real
world, so don't dump 2.4 too early please.

Regards,
Stephan


