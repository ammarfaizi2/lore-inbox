Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273829AbRI0TD7>; Thu, 27 Sep 2001 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273832AbRI0TDt>; Thu, 27 Sep 2001 15:03:49 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:2708 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S273829AbRI0TDh>; Thu, 27 Sep 2001 15:03:37 -0400
Date: Thu, 27 Sep 2001 12:03:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac16
Message-ID: <20010927120353.M13535@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 06:51:07PM +0100, Alan Cox wrote:
 
> 2.4.9-ac16
[snip]
> o	Add initial pieces for EXPORT_SYMBOL_GPL	(me)
> 	| kernel symbols for GPL only use

What's the idea behind this?  Are we now going to restrict certain parts of
the kernel to interacting with GPL-only modules?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
