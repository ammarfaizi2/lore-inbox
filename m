Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVBYAAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVBYAAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVBYAAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:00:33 -0500
Received: from hera.kernel.org ([209.128.68.125]:18338 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262576AbVBXXuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:50:35 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
Date: Thu, 24 Feb 2005 23:50:05 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cvlp7d$huv$1@terminus.zytor.com>
References: <200502211216.35194.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1109289005 18400 127.0.0.1 (24 Feb 2005 23:50:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 24 Feb 2005 23:50:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200502211216.35194.gene.heskett@verizon.net>
By author:    Gene Heskett <gene.heskett@verizon.net>
In newsgroup: linux.dev.kernel
> 
> Do I have something fubar in the usb?  Or is this just the nature of 
> the beast?
> 

USB pretty much is fubar.  It's a horrible protocol on pretty much
every level including the physical level.

	-hpa
