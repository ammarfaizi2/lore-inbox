Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUBRKSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUBRKSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:18:24 -0500
Received: from karnickel.franken.de ([193.141.110.11]:52747 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S264283AbUBRKSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:18:23 -0500
Date: Wed, 18 Feb 2004 11:17:02 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3
Message-ID: <20040218101702.GA5551@debian.franken.de>
References: <Pine.LNX.4.58.0402172013320.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402172013320.2686@home.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: erik@debian.franken.de (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 08:15:08PM -0800, Linus Torvalds wrote:
> 
> Ok, it's out.
> 
> There were some minimal changes relative to the last -rc4, mostly some 
> configuration and build fixes, but a few important one-liners too.

Ext3 doesn't seem to compile without jbd support.
