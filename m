Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUCaHek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 02:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUCaHek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 02:34:40 -0500
Received: from zero.aec.at ([193.170.194.10]:15369 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261793AbUCaHej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 02:34:39 -0500
To: Sid Boyce <sboyce@blueyonder.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
References: <1Fylv-df-27@gated-at.bofh.it> <1FzAR-1qq-5@gated-at.bofh.it>
	<1FzAR-1qq-3@gated-at.bofh.it> <1FzKy-1xG-11@gated-at.bofh.it>
	<1FAwU-2gc-11@gated-at.bofh.it> <1FAQv-2wA-57@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 31 Mar 2004 09:34:35 +0200
In-Reply-To: <1FAQv-2wA-57@gated-at.bofh.it> (Sid Boyce's message of "Wed,
 31 Mar 2004 01:30:23 +0200")
Message-ID: <m3lllh4ghg.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> writes:
>>
> 2.6.5-rc2 booting OK(with acpi), anything else 2.6.5-rc2-mm?,
> 2.6.5-rc3 or2.6.5-rc3-mm1 freezes.

Could you perhaps build your kernel with netconsole and builtin
network driver (see Documentation/networking/netconsole.txt) and get
a full boot log?  You can send it to me privately.

-Andi

