Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276907AbRJHOyx>; Mon, 8 Oct 2001 10:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276912AbRJHOyn>; Mon, 8 Oct 2001 10:54:43 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:32783 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S276911AbRJHOyg>;
	Mon, 8 Oct 2001 10:54:36 -0400
Date: Mon, 8 Oct 2001 08:49:50 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] I still see people using cli()
Message-ID: <20011008084950.B16204@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC1B831.1060601@wipro.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 07:59:05PM +0530, BALBIR SINGH wrote:
> BTW, that brings me to another issue, once the kernel becomes preemptibel, what
> are the locking issues? how are semaphores and spin-locks affected? Has anybody
> defined or come up with the rules/document yet?

IF the kernel becomes preemptible it will be so slow, so buggy, and so painful
to maintain, that those issues won't matter.

