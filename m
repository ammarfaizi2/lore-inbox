Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUBREAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUBREAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:00:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:9358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261837AbUBREAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:00:49 -0500
Date: Tue, 17 Feb 2004 20:00:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
In-Reply-To: <20040218034925.GI6242@redhat.com>
Message-ID: <Pine.LNX.4.58.0402171959560.2686@home.osdl.org>
References: <20040218031544.GB26304@redhat.com> <Pine.LNX.4.58.0402171941580.2686@home.osdl.org>
 <20040218034925.GI6242@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Dave Jones wrote:
> 
> I felt masochistic, so decided to 'see what would happen' when I ran this..

Whee. Fun. Do you actually have the hardware for it, or did it blow up 
even without any supported hardware?

		Linus
