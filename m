Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTGCLyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTGCLyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:54:17 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:38916 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265181AbTGCLyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:54:13 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Stephan von Krawczynski <skraw@ithnet.com>, Chris Mason <mason@suse.com>
Subject: Re: Status of the IO scheduler fixes for 2.4
Date: Thu, 3 Jul 2003 14:07:12 +0200
User-Agent: KMail/1.5.2
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, andrea@suse.de, piggin@cyberone.com.au
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva> <1057197726.20903.1011.camel@tiny.suse.com> <20030703125828.1347879d.skraw@ithnet.com>
In-Reply-To: <20030703125828.1347879d.skraw@ithnet.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307031407.02580.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 July 2003 12:58, Stephan von Krawczynski wrote:

Hi Stephan,

> I have a short question on that: did you check if there are any drawbacks
> on network performance through this? We had a phenomenon here with 2.4.21
> with both samba and simple ftp where network performance dropped to a crawl
> when simply entering "sync" on the console. Even simple telnet-sessions
> seemed to be affected. As we could not create a reproducable setup I did
> not talk about this up to now, but I wonder if anyone else ever checked
> that out ...
does the patch from Chris cause this?

ciao, Marc

