Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267048AbUBEWv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267049AbUBEWv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:51:28 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:8860 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267048AbUBEWvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:51:25 -0500
Date: Thu, 5 Feb 2004 16:51:23 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: Con Kolivas <kernel@kolivas.org>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-ck1
In-Reply-To: <200402060943.40973.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.58.0402051650320.14714@ryanr.aptchi.homelinux.org>
References: <200402052109.24122.kernel@kolivas.org> <200402060943.40973.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have only your patch and the 2.6.0-test9 (the latest on bootsplash.org thus
far) bootsplash patch.  I'll send you my .config separately.

-- 
Ryan Reich
ryanr@uchicago.edu

On Fri, 6 Feb 2004, Con Kolivas wrote:

> Hi Ryan
>
> >I get "bad: scheduling while atomic" on boot, before init starts.  Full
> >dmesg follows.  It appears to follow the discovery of my "initrd," which is
> >really just a bootsplash image (I don't use initrd for anything else).
>
> Do you patch in anything else? Can you send me your .config (off the list will
> be fine for this).
>
> Con
>
> P.S. It is convention on the mailing list to "reply to all" when posting a
> response on lkml.
>
