Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWEQShM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWEQShM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWEQShM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:37:12 -0400
Received: from mx1.suse.de ([195.135.220.2]:8097 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750890AbWEQShL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:37:11 -0400
Date: Wed, 17 May 2006 20:37:10 +0200
From: Olaf Hering <olh@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
Message-ID: <20060517183710.GA28931@suse.de>
References: <20060517081314.GA20415@suse.de> <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu> <20060517091056.GA21219@suse.de> <200605171014.k4HAETHT011371@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200605171014.k4HAETHT011371@turing-police.cc.vt.edu>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, May 17, Valdis.Kletnieks@vt.edu wrote:

> Is there any interest in being able to deal with AIX's LVM and/or JFS/JFS2
> (probably only read-only)?  If so, what level of support would be needed
> to make it useful?

A big company who is all hot about Linux expressed no interrest so far
to make AIX volumes readable in Linux.
