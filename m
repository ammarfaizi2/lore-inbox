Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272807AbTHKQow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272817AbTHKQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:44:51 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:46722 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S272807AbTHKQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:44:02 -0400
From: jlnance@unity.ncsu.edu
Date: Mon, 11 Aug 2003 12:44:01 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2/3 ESS1371 Audio
Message-ID: <20030811164401.GA12571@ncsu.edu>
References: <3F356881.9070206@blackmagik.dynup.net> <20030810232856.GA13070@ncsu.edu> <Pine.LNX.4.53.0308101930450.31799@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308101930450.31799@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 07:31:04PM -0400, Zwane Mwaikambo wrote:
> On Sun, 10 Aug 2003 jlnance@unity.ncsu.edu wrote:

> > FWIW, I compiled ESS1371 support into the kernel and it is found during
> > boot.  However, no sound comes from the card.  I did an strace of realplayer
> > and it is sucessfully opening /dev files for the device.  I do not know
> > when this started, as I have not been following 2.6 development closely.

> Is this ALSA or OSS?

It is ALSA with OSS emulation.

Thanks,

Jim
