Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWAXXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWAXXVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWAXXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:21:23 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:19413 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750827AbWAXXVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:21:22 -0500
Date: Wed, 25 Jan 2006 00:21:42 +0100
From: Mattia Dongili <malattia@linux.it>
To: Stefan Seyfried <seife@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: e100 oops on resume
Message-ID: <20060124232142.GB6174@inferi.kami.home>
Mail-Followup-To: Stefan Seyfried <seife@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netdev@vger.kernel.org
References: <20060124225919.GC12566@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124225919.GC12566@suse.de>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc1-mm2-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 11:59:19PM +0100, Stefan Seyfried wrote:
> Hi,
> since 2.6.16rc1-git3, e100 dies on resume (regardless if from disk, ram or
> runtime powermanagement). Unfortunately i only have a bad photo of
> the oops right now, it is available from
> https://bugzilla.novell.com/attachment.cgi?id=64761&action=view
> I have reproduced this on a second e100 machine and can get a serial
> console log from this machine tomorrow if needed.
> It did resume fine with 2.6.15-git12

I experienced the same today, I was planning to get a photo tomorrow :)
I'm running 2.6.16-rc1-mm2 and the last working kernel was 2.6.15-mm4
(didn't try .16-rc1-mm1 being scared of the reiserfs breakage).

-- 
mattia
:wq!
