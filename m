Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWCaMT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWCaMT4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWCaMT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:19:56 -0500
Received: from ns.suse.de ([195.135.220.2]:59829 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751342AbWCaMTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:19:55 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Unimplemented system call" wrong?
References: <Pine.LNX.4.61.0603311340040.18342@yvahk01.tjqt.qr>
X-Yow: I want a VEGETARIAN BURRITO to go..  with EXTRA MSG!!
Date: Fri, 31 Mar 2006 14:19:50 +0200
In-Reply-To: <Pine.LNX.4.61.0603311340040.18342@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Fri, 31 Mar 2006 13:54:12 +0200 (MEST)")
Message-ID: <jemzf66c2h.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> I seriously doubt that put_user() can return -ENOSYS

put_user can only return -EFAULT or 0.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
