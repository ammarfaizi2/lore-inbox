Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTJJQ7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTJJQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:59:09 -0400
Received: from [212.79.233.127] ([212.79.233.127]:10756 "EHLO
	mutex.ingenium-is.com") by vger.kernel.org with ESMTP
	id S263071AbTJJQ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:59:02 -0400
Message-ID: <1065805127.3f86e547dc80a@webmail.iwd.nl>
Date: Fri, 10 Oct 2003 18:58:47 +0200
From: Luite Stegeman <luite@iwd.nl>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: Sasa Ostrouska <sasa.ostrouska@volja.net>,
       James Stevenson <james@stev.org>, linux-kernel@vger.kernel.org,
       rob@nocat.net, linux-bcom4301-priv@lists.sourceforge.net
Subject: Re: [Linux-bcom4301-priv] Re: Linksys/Cisco GPL Violations
References: <Pine.LNX.4.44.0310101611190.10300-100000@Beast.ez-dsp.com> <1065799799.2277.7.camel@rc-laptop.rcdiostrouska.com> <001d01c38f4c$9e77e590$9602010a@jingle>
In-Reply-To: <001d01c38f4c$9e77e590$9602010a@jingle>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 213.93.16.124
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Florian Schirmer <jolt@tuxbox.org>:

> > Download the wrt54g.tar.gz  it is 37MB but I have not find anything
> > interesting in it. Maybe I have not looked well.
> 
> check out the WAP54G, WAP54AG or WRT54AG files. Haven't checked yet what is
> different.

There seems to be much more in the package, more developer tools, source code 
for the broadcom reference design etc. Good for the linksys router hackers, but 
unfortunately there is still no source code for the driver.

I think the driver files are in /release/src/wl. This directory contains only 
object files, no source code. The wl driver directory in the kernel tree ( 
release/src/linux/linux/drivers/net/wl ) is empty. 

I've checked the WAP54G, WAP55AG and WRT55AG archives and none of these contain 
the source code for the driver.

Luite
