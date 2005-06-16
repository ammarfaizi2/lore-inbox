Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVFPTSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVFPTSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVFPTSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 15:18:31 -0400
Received: from mail.linicks.net ([217.204.244.146]:44294 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261797AbVFPTS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 15:18:28 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: mtrr question
Date: Thu, 16 Jun 2005 20:18:25 +0100
User-Agent: KMail/1.8.1
References: <200506081917.09873.nick@linicks.net> <200506082047.13914.nick@linicks.net> <20050608195336.GL876@redhat.com>
In-Reply-To: <20050608195336.GL876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506162018.26039.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 20:53, Dave Jones wrote:

>  > I also forgot to say I use the nVidia agp module (works better for me in
>  > Quake2 for some reason)... but searching their docs doesn't even mention
>  > mtrr.
>  >
>  > Could it be that?  If so, I am wasting you guys time.
>
> Maybe. I don't use non-free drivers, so I have no idea
> what nvidia are/aren't doing in their driver.

This is confirmed it is a nvidia thing.  Tonight I have just upgraded 
(updated?) from 2.4.31 to 2.6.11.12 kernel (whooo), and used agpart - I now 
have /proc/mtrr values as expected from boot.

Quake2 works great too :-)

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
