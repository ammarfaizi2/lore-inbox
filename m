Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWARQtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWARQtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWARQtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:49:53 -0500
Received: from khc.piap.pl ([195.187.100.11]:1540 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964849AbWARQtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:49:52 -0500
To: Michael Loftis <mloftis@wgops.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
	<B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
	<43CD8A19.3010100@cfl.rr.com>
	<7A7A0F7F294BB08D7CDA264C@d216-220-25-20.dynip.modwest.com>
	<43CDA3B0.2030503@cfl.rr.com>
	<4B3A20965B8B96960504A5C8@dhcp-2-206.wgops.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 18 Jan 2006 17:49:50 +0100
In-Reply-To: <4B3A20965B8B96960504A5C8@dhcp-2-206.wgops.com> (Michael Loftis's message of "Tue, 17 Jan 2006 20:01:29 -0700")
Message-ID: <m3slrlwkep.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis <mloftis@wgops.com> writes:

> Yup we're on the same page, we just didn't think we were.  It happens
> :) R-5 (in theory) could be less reliable than a mirror

Statistically, RAID-5 with 3 or more disks is always less reliable than
a mirror. Strip size doesn't matter.

> or possibly a
> single drive,

With lot of drives.
-- 
Krzysztof Halasa
