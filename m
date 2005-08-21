Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVHUM4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVHUM4o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 08:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVHUM4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 08:56:43 -0400
Received: from [85.8.12.41] ([85.8.12.41]:7573 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750987AbVHUM4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 08:56:43 -0400
Message-ID: <43087A08.3080400@drzeus.cx>
Date: Sun, 21 Aug 2005 14:56:40 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/adfs/adfs.h: "extern inline" doesn't make sense
References: <20050819234119.GD3615@stusta.de> <20050819234443.GG3615@stusta.de>
In-Reply-To: <20050819234443.GG3615@stusta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> [ this time with a better subject ]
> 
> "extern inline" doesn't make sense.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

Isn't 'extern inline' an old gcc trick to force inlining? (instead of
just hinting)
