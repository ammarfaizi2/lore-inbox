Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVAFTCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVAFTCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVAFTCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:02:37 -0500
Received: from iPass.cambridge.arm.com ([193.131.176.58]:49333 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262944AbVAFTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:01:52 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com, greg@kroah.com,
       VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and
 ioctl_compat
References: <20041217014345.GA11926@mellanox.co.il>
	<20050103011113.6f6c8f44.akpm@osdl.org>
	<20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de>
	<20050105133448.59345b04.akpm@osdl.org>
	<20050106140636.GE25629@mellanox.co.il>
	<20050106145356.GA18725@infradead.org>
	<20050106150941.GE1830@wotan.suse.de>
	<20050106151429.GA19155@infradead.org>
	<1105024942.13396.4.camel@krustophenia.net>
	<20050106153147.GB19324@infradead.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 06 Jan 2005 19:03:18 +0000
In-Reply-To: <20050106153147.GB19324@infradead.org> (Christoph Hellwig's
 message of "Thu, 6 Jan 2005 15:31:47 +0000")
Message-ID: <tnxr7kys7m1.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> See the attached mail I got.  Btw, where are the current alsa-devel
> archives?  I tried to look things up a few times lately, but all archives
> linked off the websiste are either dead or totally outdated.

http://news.gmane.org/gmane.linux.alsa.devel/ (also available via
NNTP).

Catalin

