Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWFTCGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWFTCGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 22:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWFTCGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 22:06:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964865AbWFTCGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 22:06:53 -0400
Date: Mon, 19 Jun 2006 19:06:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
In-Reply-To: <44954102.3090901@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
References: <44954102.3090901@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Jun 2006, Stefan Richter wrote:
> 
> the IEEE 1394 subsystem updates for Linux 2.6.18 are now staged in Ben's
> revived linux1394 git tree. I guess the URL to pull from is
> git://git.kernel.org/pub/scm/linux/kernel/git/bcollins/linux1394-2.6.git

I'm sure that URL works fine, but I want to see what I'm pulling before I 
pull it, so _please_ use one of the scripts that generates diffstats and 
shortlogs, or do it by hand..

		Linus
