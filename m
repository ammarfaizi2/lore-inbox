Return-Path: <linux-kernel-owner+w=401wt.eu-S1751298AbWLLNBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWLLNBU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWLLNBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:01:20 -0500
Received: from lazybastard.de ([212.112.238.170]:53614 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbWLLNBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:01:19 -0500
Date: Tue, 12 Dec 2006 12:58:36 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Message-ID: <20061212125836.GA13786@lazybastard.org>
References: <457EA2FE.3050206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <457EA2FE.3050206@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 December 2006 07:39:26 -0500, Jeff Garzik wrote:
> 
> I have created the 'kill-jffs' branch of 
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that 
> removes fs/jffs.
> 
> I argue that you can count the users (who aren't on 2.4) on one hand, 
> and developers don't seem to have cared for it in ages.

You can count them on one finger, I guess.  The last time jffs was
proposed for removal, a single person said he still used it and would
like to keep it around.  And I haven't seen any patches come forward since.

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
