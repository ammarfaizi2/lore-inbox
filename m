Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUCLPAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUCLPAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:00:34 -0500
Received: from [193.108.190.253] ([193.108.190.253]:17891 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S262142AbUCLPAd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:00:33 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <04031207520900.07660@tabby>
References: <1078775149.23059.25.camel@luke> <04031108183602.05054@tabby>
	 <1079015949.1576.106.camel@quaoar>  <04031207520900.07660@tabby>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1079103602.1571.26.camel@quaoar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 16:00:03 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 2004-03-12 kl. 14:52 skrev Jesse Pollard:
> > Let's just for a second assume that I'm the slow one here. Why is the
> > world a less secure place after this system is incorporated into the
> > kernel?
> Because a rogue client will have access to every uid on the server.

As opposed to now when a rogue client is very well contained?

> Mapping provides a shield to protect the server.

A mapping system could provide extra security if implemented on the
server. That's true. This is, however, not what I'm trying to do. This
system is NOT a security related one (it doesn't increase nor decrease
security), but rather a convenience related one.

-- 
Salu2, Søren.

