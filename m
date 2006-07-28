Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWG1CQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWG1CQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 22:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWG1CQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 22:16:49 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6877 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932569AbWG1CQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 22:16:48 -0400
Date: Fri, 28 Jul 2006 04:16:42 +0200 (MEST)
Message-Id: <200607280216.k6S2GgiJ009955@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org, mtosatti@redhat.com, willy@w.ods.org
Subject: Re: Linux v2.4.33-rc3 (and a new v2.4 maintainer)
Cc: alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 18:30:19 -0300, Marcelo Tosatti wrote:
>Here goes the third (and hopefully last) release candidate of v2.4.33.

http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.33-rc3.bz2
is only 854 bytes long, and once bunzip2:ed it looks like it's the
incremental diff between rc2 and rc3. Usually the full pre/rc patches
go in testing/ with the incrementals going into testing/incr/.

No big deal, but it would feel better with a proper -rc3 patch there.

/Mikael
