Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTJRSWO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 14:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTJRSWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 14:22:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25729 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261941AbTJRSWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 14:22:12 -0400
Date: Sat, 18 Oct 2003 19:22:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Walt H <waltabbyh@comcast.net>
Cc: arekm@pld-linux.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: initrd and 2.6.0-test8
Message-ID: <20031018182210.GC7665@parcelfarce.linux.theplanet.co.uk>
References: <3F916A0C.10800@comcast.net> <20031018175236.GA7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018175236.GA7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 06:52:36PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
 
> Even better would be to report the bug ;-/
> 
> I can't reproduce it here.  2.6.0-test8 vanilla, so far (last 15 minutes)
> tried with
> 	* compressed initrd image
> 	* plain ext2
> and I'll try romfs as soon as I hunt down mkfs for that animal.  All
> appears to be working...

... and so it does with romfs.  Guys, please post .config and boot log.
