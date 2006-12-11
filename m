Return-Path: <linux-kernel-owner+w=401wt.eu-S1762515AbWLKFmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762515AbWLKFmY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 00:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762519AbWLKFmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 00:42:24 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:21682 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762514AbWLKFmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 00:42:23 -0500
Date: Sun, 10 Dec 2006 21:43:06 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: PAE/NX without performance drain?
Message-Id: <20061210214306.aa945b80.randy.dunlap@oracle.com>
In-Reply-To: <457CE558.8030003@comcast.net>
References: <200612102347_MC3-1-D49B-AB98@compuserve.com>
	<457CE558.8030003@comcast.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 23:58:00 -0500 John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Chuck Ebbert wrote:
> > In-Reply-To: <457B1F02.7030409@comcast.net>
> > 
> > On Sat, 09 Dec 2006 15:39:30 -0500, John Richard Moser wrote:
> > 
> >> Is it possible to give some other way to get the hardware NX bit working
> >> in 32-bit mode, without the apparently massive performance penalty of
> >> HIGHMEM64?
> > 
> > If your hardware can run the x86_64 kernel, try using that with your
> > i386 userspace.  It works here...
> > 
> 
> I hear that breaks USB printing.  Also I'm interested in getting it
> working for other people, i.e. shipping with working NX.

Where's the USB printing bug report?

---
~Randy
