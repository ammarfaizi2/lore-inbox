Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266723AbUBFVtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUBFVtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:49:40 -0500
Received: from fep06-svc.mail.telepac.pt ([194.65.5.211]:50591 "EHLO
	fep06-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S266723AbUBFVte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:49:34 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Fri, 6 Feb 2004 21:49:31 +0000
User-Agent: KMail/1.5.4
References: <4022BC15.4090502@wanadoo.es> <200402060702.15930.ctpm@rnl.ist.utl.pt> <200402062112.32212.chakkerz@optusnet.com.au>
In-Reply-To: <200402062112.32212.chakkerz@optusnet.com.au>
Cc: chakkerz@optusnet.com.au
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402062149.31011.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 06 February 2004 10:12, Christian Unger wrote:
> >   Hi, I think that's not really the problem. I'm not using KDE 3.2 and I
> > still have the problem. I'm running Debian unstable with XFree86 4.2.1
> > and KDE 3.1.5.
>
> Could be that there was a change in KDE that is present in both 3.1.5 and
> 3.2.0 ... they are only 3 weeks appart.
>

  Ok, but the fact is I didn't have those problems with the other kernel, they 
started right after I booted with 2.6.2. So the problem _must_ be related to 
2.6.2 which was the only thing that changed on this system.

  Anyway other people are reporting this with different window managers and 
even with raw X so I believe that supports the case that this is 2.6.2 
related...

regards

Claudio


