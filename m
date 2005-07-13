Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVGMD1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVGMD1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 23:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVGMD1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 23:27:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261945AbVGMD1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 23:27:08 -0400
Date: Tue, 12 Jul 2005 20:26:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH/SCRIPT] reiserfs: run scripts/Lindent on reiserfs code
In-Reply-To: <20050712232412.GA9669@locomotive.unixthugs.org>
Message-ID: <Pine.LNX.4.58.0507122022530.17536@g5.osdl.org>
References: <20050712232412.GA9669@locomotive.unixthugs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jul 2005, Jeff Mahoney wrote:
> 
> scripts/Lindent fs/reiserfs/*.c include/linux/reiserfs_*.h

Ok, applied. You should check that you got the same results I did, and 
feel free to send further cleanup patches. Sometimes "indent" does some 
silly things.

		Linus
