Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262671AbTCUBLE>; Thu, 20 Mar 2003 20:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbTCUBLD>; Thu, 20 Mar 2003 20:11:03 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:43507 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262671AbTCUBLD>; Thu, 20 Mar 2003 20:11:03 -0500
Date: Thu, 20 Mar 2003 17:20:58 -0800
From: Chris Wright <chris@wirex.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Release of 2.4.21
Message-ID: <20030320172058.A30322@figure1.int.wirex.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20030320200019$6ddc@gated-at.bofh.it> <20030320203015$4839@gated-at.bofh.it> <8765qdg46i.fsf@deneb.enyo.de> <20030320210305.GH8256@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030320210305.GH8256@gtf.org>; from jgarzik@pobox.com on Thu, Mar 20, 2003 at 04:03:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> 
> The ptrace bug is only one of several local root holes.  IIS would imply
> a remote vulnerability, something _far_ more serious.
> 
> This specific ptrace hole is closed, yay.  Now what about the other
> 10,001 that still exist?  People are blowing this ptrace bug WAY
> out of proportion.   The only reason why it demands a modicum of
> vendor responsibility is that a-holes are making easy-to-use exploits
> available for the script kiddies.

I know it's already been said, but IMHO it needs to be underscored.  Local
root holes are just a simple non-root remote exploit away from being
remotely exploitable root holes.  Both are often considered
insignificant, and that is scary!  As far as fileutils...couldn't agree
more ;-)  But that doesn't make a locally exploitable root hole in the
kernel any less significant.

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
