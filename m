Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWBASdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWBASdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWBASdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:33:53 -0500
Received: from khc.piap.pl ([195.187.100.11]:39172 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1422863AbWBASdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:33:52 -0500
To: md@Linux.IT (Marco d'Itri)
Cc: netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Backward compatibility and WAN netdev configuration
References: <m3psm7tksr.fsf@defiant.localdomain>
	<20060201144917.GA7644@wonderland.linux.it>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 01 Feb 2006 19:33:47 +0100
In-Reply-To: <20060201144917.GA7644@wonderland.linux.it> (Marco d'Itri's message of "Wed, 1 Feb 2006 15:49:17 +0100")
Message-ID: <m3r76n3p4k.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

md@Linux.IT (Marco d'Itri) writes:

> Why you cannot support autoloading the modules when a specific protocol
> is needed?

I probably could but it would complicate things a bit - currently only
the protocol module knows about existence of its protocol.

I will look at it, though. Thanks.
-- 
Krzysztof Halasa
