Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTE0Tfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTE0Tfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:35:39 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:46086 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264097AbTE0Tff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:35:35 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
Date: Tue, 27 May 2003 21:46:04 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Jens Axboe <axboe@suse.de>
References: <200305272104.05802.m.c.p@wolk-project.de> <200305272130.43814.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271631590.9487@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271631590.9487@freak.distro.conectiva>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305272145.30738.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 21:34, Marcelo Tosatti wrote:

Hi Marcelo,

>  - 2.4.22 is going to be a short release, meaning we will have this
>    bug fixed soon in a final release.
>  - the bug is around for quite some time now, its not very critical.
>  - its -rc stage.
k.

> I will work with Jens, Axboe and Andrea to get this properly fixed in .22
> in case Andrea patch is not OK.
great. Just remember: fix-pausing-2 fix does _not_ fix the pauses/stops/mouse 
is dead/keyboard is dead/ problem. It fixes the "process stuck in D state" 
problem.

Please bear it in mind.

ciao, Marc

