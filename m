Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVCHMsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVCHMsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVCHMsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:48:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262026AbVCHMra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:47:30 -0500
Subject: Re: Linux 2.6.11-ac1
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Stephen Tweedie <sct@redhat.com>, Clemens Schwaighofer <cs@tequila.co.jp>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050308064926.GV28536@shell0.pdx.osdl.net>
References: <1110231261.3116.90.camel@localhost.localdomain>
	 <B0B9168A9B666B9CF980CB7C@[192.168.12.2]>
	 <20050308064926.GV28536@shell0.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1110286034.1941.33.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 08 Mar 2005 12:47:14 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-03-08 at 06:49, Chris Wright wrote:

> Yes, we are intending to pick up bits from -ac (you might have missed
> that in another thread).

There's actually a successor patch to that which I'm just about to get
feedback on here and on ext2-devel.  It's higher-risk than the one Alan
has already picked up, but also hopefully closes the race much more
tightly throughout the whole of the jbd layer.

--Stephen


