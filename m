Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWAPJFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWAPJFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWAPJFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:05:41 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:21894 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1751107AbWAPJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:05:40 -0500
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] screen remains blank after LID switch use
In-Reply-To: <200601160946.51765.lkml@kcore.org>
References: <200601160946.51765.lkml@kcore.org>
Date: Mon, 16 Jan 2006 09:05:39 +0000
Message-Id: <E1EyQJ1-0006Do-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck <lkml@kcore.org> wrote:

> I've recently gotten an Dell D610 laptop from my company. After some digging I 
> managed to get Linux running on it, with kernel 2.6.15 at this moment.

It's a bug in Dell's BIOS. It seems to be present in all their current
machines that use Intel graphics, and it also happens in Windows if you
boot in safe mode. I'm trying to work this through with Dell, but it's
taking a long time and I'm ridiculously busy with real life right now.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
