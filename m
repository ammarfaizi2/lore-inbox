Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVBYOMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVBYOMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVBYOMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:12:30 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:7826 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262702AbVBYOM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:12:28 -0500
Subject: Re: [PATCH] Determine SCx200 CB address at run-time
From: Henrik Brix Andersen <brix@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1109248603.12001.7.camel@sponge.fungus>
References: <1109163214.12284.2.camel@sponge.fungus>
	 <1109248603.12001.7.camel@sponge.fungus>
Content-Type: text/plain
Organization: Gentoo Linux
Date: Fri, 25 Feb 2005 15:12:26 +0100
Message-Id: <1109340746.12351.7.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 13:36 +0100, Henrik Brix Andersen wrote:
> I see that this didn't make it into linux-2.6.11-rc5. Please re-consider
> for -rc6 as the SCx200 drivers are useless on Soekris Engineering
> hardware without this patch.

An updated patch for 2.6.11-rc5 can be found at
http://dev.gentoo.org/~brix/files/net4801/linux-2.6.11-rc5-scx200.patch

Sincerely,
Brix
-- 
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

