Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUCaSAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 13:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUCaSAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 13:00:32 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:52231 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261852AbUCaSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 13:00:31 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm2
Date: Wed, 31 Mar 2004 20:00:19 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
References: <20040331014351.1ec6f861.akpm@osdl.org> <200403311937.41510@WOLK>
In-Reply-To: <200403311937.41510@WOLK>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403312000.19963@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 19:37, Marc-Christian Petersen wrote:

Hi again,

> > cfq-4.patch
> >   CFQ io scheduler
> >   CFQ fixes
> is there any reason why I see /sys/block/hda/queue/iosched/ beeing empty? I
> thought every I/O scheduler would put in there some tunables or at least
> some info's what defaults are used. Or did I miss something completely and
> now I am totally wrong?

maybe it's not clear enough: I talk about CFQ as quoted above.

ciao, Marc
