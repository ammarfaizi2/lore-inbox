Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWAMOyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWAMOyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbWAMOyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:54:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60290 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422700AbWAMOyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:54:52 -0500
Date: Fri, 13 Jan 2006 15:54:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: remove kmalloc wrapper
In-Reply-To: <Pine.LNX.4.58.0601130951160.22049@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.61.0601131553570.7435@yvahk01.tjqt.qr>
References: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
 <20060112233920.4b3b0a26.akpm@osdl.org> <Pine.LNX.4.58.0601130942540.20349@sbz-30.cs.Helsinki.FI>
 <20060112234846.3a20f5a1.akpm@osdl.org> <Pine.LNX.4.58.0601130951160.22049@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> It would have helped had you described the exact /proc pathname so people
>> could remember whether there's anything which actually uses it.
>
>That would be /proc/fs/reiserfs/super, I think.

I am on 2.6.15-rc6 and there is no /proc/fs/reiserfs, even though my 
rootfs is reiserfs (and therefore, is mounted, loaded, etc.).


Jan Engelhardt
-- 
