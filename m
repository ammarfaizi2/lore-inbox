Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTEWFUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 01:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTEWFUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 01:20:34 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:38404 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263628AbTEWFUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 01:20:33 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "Barry K. Nathan" <barryn@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc3
Date: Fri, 23 May 2003 07:32:49 +0200
User-Agent: KMail/1.5.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva> <20030523005149.GA2420@ip68-101-124-193.oc.oc.cox.net>
In-Reply-To: <20030523005149.GA2420@ip68-101-124-193.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305230732.49914.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 May 2003 02:51, Barry K. Nathan wrote:

Hi Barry,

> >   o ioperm fix
> If this is the same code that's in Red Hat's latest security errata, I
> think this may be broken (makes some programs segfault). 2.5 seems fine.
> I'll reply with more details (and/or file a RH Bugzilla report) later
> today, after I double-check things in a more controlled environment.
nono, this fix is the right one. All works fine :-)

ciao, Marc
