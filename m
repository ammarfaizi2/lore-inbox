Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWGJUwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWGJUwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWGJUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:52:20 -0400
Received: from [198.99.130.12] ([198.99.130.12]:32749 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965177AbWGJUwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:52:19 -0400
Date: Mon, 10 Jul 2006 16:52:15 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Philippe Troin <phil@fifi.org>
Cc: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
Message-ID: <20060710205215.GA6400@ccure.user-mode-linux.org>
References: <44B0FAD5.7050002@argo.co.il> <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com> <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com> <20060710034250.GA15138@thunk.org> <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com> <20060710185435.GA5445@ccure.user-mode-linux.org> <874pxp1at0.fsf@tantale.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874pxp1at0.fsf@tantale.fifi.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 01:09:47PM -0700, Philippe Troin wrote:
> I usually do the same, except that I write the errno in case of
> failure.  This way the parent knows *why* exec failed ;-)

If you look at the code I posted, it does exactly that.

				Jeff
