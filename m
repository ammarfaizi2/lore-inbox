Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268156AbUHKSWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268156AbUHKSWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUHKSWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:22:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:40580 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268156AbUHKSWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:22:09 -0400
Date: Wed, 11 Aug 2004 20:22:08 +0200
From: Olaf Hering <olh@suse.de>
To: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040811182208.GA8786@suse.de>
References: <20040811085326.GA11765@elf.ucw.cz> <1092215024.2816.8.camel@laptop.fenrus.com> <yw1x657q9gna.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x657q9gna.fsf@kth.se>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Aug 11, Måns Rullgård wrote:

> Seriously, though, isn't hotplug supposed to handle plugging and
> unplugging of hardware, rather than any random events detected by the
> kernel?

/sbin/kernel_event_notifier was named /sbin/hotplug by accident.
I'm sure someone will send a patch to fix it up.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
