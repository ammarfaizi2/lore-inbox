Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264023AbUDVNWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbUDVNWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUDVNWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:22:53 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:62854 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S264023AbUDVNWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:22:50 -0400
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Giuliano Pochini <pochini@shiny.it>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cfriesen@nortelnetworks.com,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
In-Reply-To: <XFMail.20040422102359.pochini@shiny.it>
References: <XFMail.20040422102359.pochini@shiny.it>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1082640135.1059.93.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Apr 2004 09:22:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 04:23, Giuliano Pochini wrote:

> Yes, but it is possible, expecially for long sessions. 

In other words, 80% or more of internet traffic would not be affected
still using http1.0 would not be affected.
And for something like a huge download to just regular joe, this is more
of a nuisance assuming some kiddie has access between you and the
server.
OTOH, long lived BGP sessions are affected assuming you are going across
hostile path to your peer.

So whats all this ado about nothing? Local media made it appear we are
all about to die.

Is anyone working on some fix?

cheers,
jamal

