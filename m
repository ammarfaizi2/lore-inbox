Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265262AbUFWAug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265262AbUFWAug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 20:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUFWAug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 20:50:36 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:28099 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265262AbUFWAuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 20:50:35 -0400
Date: Tue, 22 Jun 2004 20:50:34 -0400
From: Tom Vier <tmv@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7: preempt + sysfs = BUG on ppc
Message-ID: <20040623005034.GA29120@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20040620153922.GA20103@zero> <20040620144906.095a4f93.akpm@osdl.org> <20040621234425.GA24935@zero> <20040621172611.420ff9f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621172611.420ff9f9.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 05:26:11PM -0700, Andrew Morton wrote:
> > here ya go. it's /sys/class/net/eth1/wireless/beacon. that's for my airport
> > card (apple branded lucent chip). i would look at its sysfs code, but i'm
> > not familiar with it at all (and i'm busy).
> 
> What device driver is this thing using?

hermes.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
