Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUDARKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUDARKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:10:44 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:265 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262932AbUDARKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:10:35 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: disable-cap-mlock
Date: Thu, 1 Apr 2004 19:11:15 +0200
User-Agent: KMail/1.6.1
Cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, kenneth.w.chen@intel.com
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random>
In-Reply-To: <20040401165952.GM18585@dualathlon.random>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404011911.15953@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 18:59, Andrea Arcangeli wrote:

Hi Andrea, Bill,

> > Something like this would have the minor advantage of zero core impact.
> > Testbooted only. vs. 2.6.5-rc3-mm4

Cool!

> I certainly like this too (despite it's more complicated but it might
> avoid us to have to add further sysctl in the future), Andrew what do
> you prefer to merge? I don't mind either ways.

I'd vote for caps via sysctl.

ciao, Marc
