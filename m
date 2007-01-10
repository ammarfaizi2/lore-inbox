Return-Path: <linux-kernel-owner+w=401wt.eu-S964924AbXAJQBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbXAJQBr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 11:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbXAJQBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 11:01:46 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38058 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964924AbXAJQBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 11:01:46 -0500
Date: Wed, 10 Jan 2007 17:01:49 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jean Delvare <khali@linux-fr.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: .version keeps being updated
Message-ID: <20070110160149.GA28858@aepfle.de>
References: <20070109102057.c684cc78.khali@linux-fr.org> <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org> <Pine.LNX.4.64.0701101426400.14458@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701101426400.14458@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, Roman Zippel wrote:

> [PATCH] fix linux banner format string
> 
> Revert previous attempts at messing with the linux banner string and 
> simply use a separate format string for proc.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Acked-by: Olaf Hering <olaf@aepfle.de>

