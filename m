Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWC0Ii0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWC0Ii0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWC0Ii0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:38:26 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:31887 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750798AbWC0IiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:38:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sJmfbeIszWg0NPW4Wd6Z72tbV6yOInLRSOhh3yfzCjz/9dYxix0XcUsfUi9NPN0nuO+V7VMG9f6gdnzZY/I197vRAjGNi8RyisqnF5UE0mw1dS/CmmEhl/xwYGpQVA9r9Z/1rTdfzPwTYuwDDlaHKTD9Oc3+GV4nbtFOdEEnXEs=
Message-ID: <4427A46F.8090500@gmail.com>
Date: Mon, 27 Mar 2006 16:38:07 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [Linux-fbdev-devel] [2.6 patch] framebuffer: Remove old radeon
 driver
References: <20060326122521.GK4053@stusta.de>
In-Reply-To: <20060326122521.GK4053@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> From: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> This patch removes the old radeon driver which has been replaced by a
> newer one.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Antonino Daplas <adaplas@pol.net>

Tony
