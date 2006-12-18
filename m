Return-Path: <linux-kernel-owner+w=401wt.eu-S1754471AbWLRTmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbWLRTmy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbWLRTmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:42:54 -0500
Received: from lucidpixels.com ([66.45.37.187]:49879 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471AbWLRTmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:42:53 -0500
X-Greylist: delayed 1294 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 14:42:53 EST
Date: Mon, 18 Dec 2006 14:21:18 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: NFS Filesystem Size Limit?
Message-ID: <Pine.LNX.4.64.0612181419010.2396@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question I could not quickly find on Google/mailing lists--

Say I have some sort of global filesystem or NFS which is 200TB.

Is there a limit either:

A) In the Linux kernel
or
B) In the NFS spec

That would limit the client as to what it could see via NFS or global 
filesystem?

Or could both 2.4 and 2.6 kernels 'see' the 200TB global filesystem over 
NFS or global filesystem?

Justin.
