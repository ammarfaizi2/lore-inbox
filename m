Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWHFVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWHFVwR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWHFVwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:52:17 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:2182 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750728AbWHFVwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:52:17 -0400
Message-ID: <44D66491.1090606@drzeus.cx>
Date: Sun, 06 Aug 2006 23:52:17 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Ben Dooks <ben@fluff.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx> <20060806204842.GE16816@flint.arm.linux.org.uk> <44D657BF.6070004@drzeus.cx> <20060806210509.GF16816@flint.arm.linux.org.uk> <44D65F4D.3060907@drzeus.cx> <20060806213524.GC8907@home.fluff.org>
In-Reply-To: <20060806213524.GC8907@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> ISA is very easy to glue to the simple IO busses on many
> systems such as ARM.
>
>   

Sorry, my intention wasn't to assert that it was only to be used on x86
but that the 16-bit assumption was safe.

