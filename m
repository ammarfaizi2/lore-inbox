Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265824AbUGDWZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbUGDWZy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUGDWZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:25:54 -0400
Received: from zero.aec.at ([193.170.194.10]:5897 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265824AbUGDWZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:25:53 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: procfs permissions on 2.6.x
References: <2dZjc-7BP-15@gated-at.bofh.it> <2dZjf-7BP-27@gated-at.bofh.it>
	<2dZsQ-7GF-23@gated-at.bofh.it> <2dZVV-867-33@gated-at.bofh.it>
	<2e0oZ-8lm-35@gated-at.bofh.it> <2emSs-6R8-17@gated-at.bofh.it>
	<2enbS-72q-19@gated-at.bofh.it> <2env9-7li-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 05 Jul 2004 00:25:49 +0200
In-Reply-To: <2env9-7li-9@gated-at.bofh.it> (viro@parcelfarce.linux.theplanet.co.uk's
 message of "Mon, 05 Jul 2004 00:20:07 +0200")
Message-ID: <m34qone7f6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:
>
> Why on the earth do we ever want to allow chown/chmod on procfs in the first
> place?

It's useful to stop other people from reading your environment
or command line.

-Andi

