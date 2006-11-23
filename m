Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933316AbWKWJIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbWKWJIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbWKWJIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:08:31 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:14266 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S933316AbWKWJIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:08:30 -0500
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net,
       James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org,
       linuxppc-dev@ozlabs.org, sammy@sammy.net, sun3-list@redhat.com
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
References: <20061118000235.GV31879@stusta.de>
	<Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
From: Jes Sorensen <jes@sgi.com>
Date: 23 Nov 2006 04:08:29 -0500
In-Reply-To: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
Message-ID: <yq0k61mv8c2.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michael" == Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> writes:

Michael> On Sat, 18 Nov 2006, Adrian Bunk wrote:
>> This patch removes video drivers that: - had already been marked as
>> BROKEN in 2.6.0 three years ago and - are still marked as BROKEN.
>> 
>> These are the following drivers: - FB_CYBER - FB_VIRGE -
>> FB_RETINAZ3 - FB_ATARI

Michael> FB_ATARI has just been revived. Geert has a preliminary
Michael> patch; I'll send the final one soonish.

I'm probably the only one with a RetinaZ3 left but the machine hasn't
been booted for quite a while..... not sure if I'll get to it in the
near future, but I can always resurrect the patches from an old kernel
and start from there if I do.

Jes
