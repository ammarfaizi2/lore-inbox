Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUHKU3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUHKU3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268217AbUHKU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:29:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58297 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268221AbUHKU3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:29:19 -0400
Date: Wed, 11 Aug 2004 22:22:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040811202229.GB1550@openzaurus.ucw.cz>
References: <20040811085326.GA11765@elf.ucw.cz> <411A239C.8060606@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411A239C.8060606@blue-labs.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Would you mind improving this slightly, instead of returning on 
> failure, idle on failure so the cpu cools down from lack of 
> instruction execution?  Is this easily done?

Well, but that would kill the system, right?

I do not want to do that. Hardware will kill us anyway if
overheat is serious.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

