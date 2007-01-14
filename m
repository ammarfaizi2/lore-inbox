Return-Path: <linux-kernel-owner+w=401wt.eu-S1751626AbXANTTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbXANTTb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbXANTTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:19:31 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46301 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbXANTTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:19:30 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 14 Jan 2007 20:19:18 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: allocation failed: out of vmalloc space error treating and
 =?iso-8859-1?Q?VIDEO1394_IOC_LISTEN_CHANNEL_ioctl=A0failed_problem?=
To: theSeinfeld@users.sourceforge.net, linux-kernel@vger.kernel.org
cc: libdc1394-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <200701100023.39964.theSeinfeld@users.sf.net>
Message-ID: <tkrat.c0a43c7c901c438c@s5r6.in-berlin.de>
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net>
 <200701100023.39964.theSeinfeld@users.sf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan, Peter Antoniac wrote:
[...]
> Problem is: how to get the VMALLOC_RESERVED value for the kernel that is 
> running? I couldn't find any standard way to do that (something to apply to 
> GNU Linux and the like). All the things I could get were the default value 
> being 128MiB :) and that is it. Now, I could just put 128, but what if 
> somebody changes that, or in some new distro suddenly decides to make it 
> different? Even worse, what if it is an old kernel with 64 setting?
[...]

Maybe somebody at LKML has answers?
-- 
Stefan Richter
-=====-=-=== ---= -===-
http://arcgraph.de/sr/

