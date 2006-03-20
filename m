Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWCTVet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWCTVet (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWCTVet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:34:49 -0500
Received: from hera.kernel.org ([140.211.167.34]:53916 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964905AbWCTVes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:34:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Date: Mon, 20 Mar 2006 13:34:07 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dvn74f$lim$1@terminus.zytor.com>
References: <20060320212338.GA11571@kroah.com> <20060320133230.ae739f58.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1142890447 22103 127.0.0.1 (20 Mar 2006 21:34:07 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 20 Mar 2006 21:34:07 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060320133230.ae739f58.rdunlap@xenotime.net>
By author:    "Randy.Dunlap" <rdunlap@xenotime.net>
In newsgroup: linux.dev.kernel
> ioctl-number.txt

Do not remove from ioctl-number.txt; those ioctl numbers should not be
reused.

	-hpa
