Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVAMDSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVAMDSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVAMDSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:18:43 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:17055 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261156AbVAMDSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:18:38 -0500
Message-ID: <41E5E888.4050605@g-house.de>
Date: Thu, 13 Jan 2005 04:18:32 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>
Subject: Re: thoughts on kernel security issues
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <Pine.LNX.4.58.0501121222590.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501121222590.2310@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>
> we can make it. If that means that we should make the changelogs be a bit 
> less verbose because we don't want to steal the thunder from the people 
> who found the problem, that's fine.

what the....no!!

changelogs have to be verbose, i'm still often missing hints in the 
current changelogs, commenting that patch_a and update_b got in because 
of a security issue. some boxes need only be updated for the sake of 
security, so one would be happy only watching for <security patch> lines 
in the kernel changlogs. giving credits to the people who found the 
problem is still possible by mentioning the (source of the)original 
advisory.

Christian.
-- 
BOFH excuse #30:

positron router malfunction
