Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUB2Omu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 09:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUB2Omu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 09:42:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262056AbUB2Oll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 09:41:41 -0500
Date: Sun, 29 Feb 2004 14:41:41 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maurice van der Stee <stee@planet.nl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.4-rc1 oops on HPFS filesystem file rename
Message-ID: <20040229144141.GJ16357@parcelfarce.linux.theplanet.co.uk>
References: <20040228171259.GA587@maurice.stee.nl> <20040228190649.GF16357@parcelfarce.linux.theplanet.co.uk> <20040229113130.GA577@maurice.stee.nl> <20040229131425.GH16357@parcelfarce.linux.theplanet.co.uk> <20040229135849.GI16357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229135849.GI16357@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 01:58:49PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Additional patch later today...

Same place, HPFS9-hpfs_deadlock-RC4-rc1 (on top of the previous).  It's
obviously going to be reordered before it gets submitted, but for now
I'd rather just drop incrmentals there...

I'll do reordering in a couple of hours.
