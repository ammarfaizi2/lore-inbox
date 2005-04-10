Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVDJPJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVDJPJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 11:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVDJPJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 11:09:17 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:28364 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261509AbVDJPI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 11:08:28 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: James Morris <jmorris@redhat.com>
Cc: johnpol@2ka.mipt.ru, Thomas Graf <tgraf@suug.ch>,
       Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, ijc@hellion.org.uk,
       guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev <netdev@oss.sgi.com>
In-Reply-To: <Xine.LNX.4.44.0504101055470.8507-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0504101055470.8507-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1113145700.1088.324.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Apr 2005 11:08:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 10:56, James Morris wrote:
> On 10 Apr 2005, jamal wrote:
> 
> > Thats what the original motivation for konnector was. To make it easy
> > for joe dumbass.
> 
> Who you really want writing kernel code :-)

Ok, let me take that back then ;->
The value is in allowing people who are kernel hackers that are trying
to focus on an entirely different problem to not really know much about
the internals of the messaging subsystem (if you wanna call netlink
that). A good example will be the fork patches which were posted
recently.

cheers,
jamal

