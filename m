Return-Path: <linux-kernel-owner+w=401wt.eu-S965046AbXAGUE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbXAGUE7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbXAGUE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:04:59 -0500
Received: from eazy.amigager.de ([213.239.192.238]:51349 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965046AbXAGUE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:04:59 -0500
Date: Sun, 7 Jan 2007 21:04:53 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070107200453.GA3227@thinkpad.home.local>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org
References: <20070107151744.GA9799@dose.home.local> <1168194194.18788.63.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168194194.18788.63.camel@mindpipe>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 13:23:13 -0500, Lee Revell wrote:
> On Sun, 2007-01-07 at 16:17 +0100, Tino Keitel wrote:
> > No information about the device/driver that refuses to resume.
> 
> You should be able to identify the problematic driver by removing each
> driver manually before suspending.

I can not reproduce it anymore, resume now works. I really hope that it
will stay so.

Regards,
Tino
