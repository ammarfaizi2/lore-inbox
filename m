Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbUKDMhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbUKDMhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUKDMgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:36:35 -0500
Received: from sd291.sivit.org ([194.146.225.122]:7901 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262198AbUKDMf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:35:57 -0500
Date: Thu, 4 Nov 2004 13:36:05 +0100
From: Stelian Pop <stelian@popies.net>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/12] meye driver update
Message-ID: <20041104123602.GX3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Emmanuel Fleury <fleury@cs.aau.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041104111231.GF3472@crusoe.alcove-fr> <1099571129.23751.22.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099571129.23751.22.camel@rade7.e.cs.auc.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 01:25:29PM +0100, Emmanuel Fleury wrote:

> By the way, is there any news for the development of a driver for the
> meye of a PCG-C1MZX ?
> 
> lspci:
[...]
> 0000:00:0a.0 Multimedia controller: Fujitsu Limited.: Unknown device 2011
[...]
> 0000:00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
[...]

> Chipset of the meye (I guess): 
> 
> Ricoh Co Ltd RL5c475 (rev 80)

No, that's the cardbus bridge.

The camera is the Fujitsu device (0x10cf/0x2011).

There is a page at http://r-engine.sourceforge.net/ but the project
seems dead. The manufacturer has given to several developers the
docs (under a non redistribution NDA), but nobody wrote some code
yet.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
