Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261981AbTCTUwM>; Thu, 20 Mar 2003 15:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261982AbTCTUwM>; Thu, 20 Mar 2003 15:52:12 -0500
Received: from havoc.daloft.com ([64.213.145.173]:50134 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261981AbTCTUwL>;
	Thu, 20 Mar 2003 15:52:11 -0500
Date: Thu, 20 Mar 2003 16:03:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Release of 2.4.21
Message-ID: <20030320210305.GH8256@gtf.org>
References: <20030320200019$6ddc@gated-at.bofh.it> <20030320203015$4839@gated-at.bofh.it> <8765qdg46i.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8765qdg46i.fsf@deneb.enyo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 09:43:01PM +0100, Florian Weimer wrote:
> Releasing an official 2.4.21 with some fixes (and no new features) is
> just a PR issue.  I've already seen people comparing the alleged IIS
> bug (or this new IE hole) and the ptrace() bug...

Comparing, how?  There is no comparison.

The ptrace bug is only one of several local root holes.  IIS would imply
a remote vulnerability, something _far_ more serious.

This specific ptrace hole is closed, yay.  Now what about the other
10,001 that still exist?  People are blowing this ptrace bug WAY
out of proportion.   The only reason why it demands a modicum of
vendor responsibility is that a-holes are making easy-to-use exploits
available for the script kiddies.

In my more cynical moods, I wish bugtraq'ers would start posting
exploits to all the races in GNU coreutils (cp/mv/rm/...).  Assuming
such actions would (finally) lead to bug fixes.... maybe then I will
start taking local root holes a bit more seriously.  I will no more
than hint about this in public, but will respond privately with details
(if I know you).

	Jeff



