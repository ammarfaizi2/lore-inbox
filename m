Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVDKC07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVDKC07 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 22:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVDKC07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 22:26:59 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:24709 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261664AbVDKC05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 22:26:57 -0400
Date: Sun, 10 Apr 2005 22:25:06 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pnp/pnpbios/rsparser.c: fix an array overflow
Message-ID: <20050411022505.GA7793@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050409180352.GD3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409180352.GD3632@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 08:03:52PM +0200, Adrian Bunk wrote:
> This patch fixes an array overflow found by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

Looks good.

Thanks,
Adam
