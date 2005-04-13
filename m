Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVDMGgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVDMGgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 02:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVDMGgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 02:36:47 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:39319 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262306AbVDMGgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 02:36:41 -0400
To: Asfand Yar Qazi <ay0305@qazi.f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why not GNU Arch instead of BitKeeper?
References: <425CB996.5090905@qazi.f2s.com>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Wed, 13 Apr 2005 15:36:35 +0900
In-Reply-To: <425CB996.5090905@qazi.f2s.com> (Asfand Yar Qazi's message of "Wed, 13 Apr 2005 07:17:58 +0100")
Message-ID: <buo1x9f41zg.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asfand Yar Qazi <ay0305@qazi.f2s.com> writes:
> I'm surprised nobody considered GNU Arch 
> (http://www.gnu.org/software/gnu-arch/) to replace BitKeeper - it was 
> probably started in direct response to the Linux Kernel using a 
> non-free tool.
>
> I must say I haven't used it, but from reviews and comparisons I've 
> read, it seems to be a good tool.

I agree (I use it) -- but of course it has its own issues.  For instance
it has a _lot_ less attention payed to optimization than one might wish
(judging from "git", this is very important to Linus :-).  The concept
of "archives" and their associated namespace offer some nice advantages,
but is a very different model than BK uses, and I presume sticking with
the familiar and simple BK model was attractive.

-Miles
-- 
Suburbia: where they tear out the trees and then name streets after them.
