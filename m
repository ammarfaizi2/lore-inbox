Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUDVNqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUDVNqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbUDVNqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:46:54 -0400
Received: from denise.shiny.it ([194.20.232.1]:18636 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S264044AbUDVNqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:46:52 -0400
Date: Thu, 22 Apr 2004 15:46:05 +0200 (CEST)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: jamal <hadi@cyberus.ca>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cfriesen@nortelnetworks.com,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <1082640135.1059.93.camel@jzny.localdomain>
Message-ID: <Pine.LNX.4.58.0404221532480.670@denise.shiny.it>
References: <XFMail.20040422102359.pochini@shiny.it> <1082640135.1059.93.camel@jzny.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Apr 2004, jamal wrote:

> On Thu, 2004-04-22 at 04:23, Giuliano Pochini wrote:
>
> > Yes, but it is possible, expecially for long sessions.
>
> In other words, 80% or more of internet traffic would not be affected
> still using http1.0 would not be affected.
> And for something like a huge download to just regular joe, this is more
> of a nuisance assuming some kiddie has access between you and the
> server.

No, TCP/IP is 100% vulnerable to the man-in-the-middle attach. There is no
cure for that. Some devices or softwares called "firewall" are designed to
cut or to modify connections. :)
This vulnerability is about external attacks.


--
Giuliano.
