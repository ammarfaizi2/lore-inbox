Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVFANET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVFANET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVFANES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:04:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38556 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261273AbVFANDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:03:19 -0400
Date: Wed, 1 Jun 2005 15:02:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Freezer Patches.
Message-ID: <20050601130205.GA1940@openzaurus.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117629212.10328.26.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here are the freezer patches. They were prepared against rc3, but I
> think they still apply fine against rc5. (Ben, these are the same ones I
> sent you the other day).

304 seems ugly and completely useless for mainline
300: stopping softirqd seems dangerous to me... are you sure?
301: patching exit should not be neccessary. Why do you need it?
				Pavel




-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

