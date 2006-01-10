Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932617AbWAJUqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWAJUqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWAJUqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:46:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:18337 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932617AbWAJUqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:46:48 -0500
From: Andi Kleen <ak@suse.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Date: Tue, 10 Jan 2006 21:46:34 +0100
User-Agent: KMail/1.8.2
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr> <20060110202920.GA5479@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060110202920.GA5479@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601102146.35117.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 21:29, Josef Sipek wrote:

> There is a config option that lets you specify the size of this buffer:
> CONFIG_LOG_BUF_SHIFT

That is the dmesg buffer, not the scroll back buffer. Completely different
things.

-Andi

