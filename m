Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTD1MM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 08:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTD1MM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 08:12:59 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:14275 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262682AbTD1MM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 08:12:58 -0400
Date: Mon, 28 Apr 2003 14:25:08 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Oliver Feiler <kiza@gmx.net>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: Mailinglist problems?
In-Reply-To: <200304281335.54932.kiza@gmx.net>
Message-ID: <Pine.LNX.4.51.0304281422500.412@dns.toxicfilms.tv>
References: <200304281223.53020.kiza@gmx.net> <20030428112434.GH24892@mea-ext.zmailer.org>
 <200304281335.54932.kiza@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   Most common troubles that users have are:
> >     - "Relaying denied"  (in its many forms
> > 	  -->   http://vger.kernel.org/mxverify.html )
Btw. I tried mxverify script on my SMTP.
At the bottom it says:

Testing server at address: IPv6 3ffe:8320:2:18::57

ERROR: Failed to create AF_INET6 type socket! err='Address family not
supported by protocol'

I am IP6 enabled, so is my SMTP, so it appears that host the script is
running is not ip6 enabled.

Just letting you know.

Regards,
Maciej

