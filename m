Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUCKOq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUCKOq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:46:29 -0500
Received: from [193.108.190.253] ([193.108.190.253]:28334 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S261389AbUCKOqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:46:03 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <04031108310203.05054@tabby>
References: <1078775149.23059.25.camel@luke>
	 <1078958747.1940.80.camel@nidelv.trondhjem.org>
	 <1078993757.1576.41.camel@quaoar>  <04031108310203.05054@tabby>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1079016339.1576.114.camel@quaoar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 15:45:40 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2004-03-11 kl. 15:31 skrev Jesse Pollard:
> > Because that would require changes to both ends of the wire. I
> > want this to:
> > 1. Work for ALL filesystems (NFS, smbfs, ext2(*) etc.)
> > 2. Be transparent for the server.
> It will be a major security vulnerability.

Well, I COULD repeat myself over and over again....
Short answer:
No.
Long answer:
Nooo.

> > *: For ext2, this could come in handy if you are moving disks between
> > systems.
> Mapping fails in this case due to UID loops (been there done that too

You haven't seen a line of code I've written for this yet, and already
you're telling me that I implemented it the wrong way because that's
what you did when you once tried?

I BTW also fail to see why it all of the sudden is my problem that
people have more than one user on the same system. (Hint: it isn't)

-- 
Salu2, Søren.

