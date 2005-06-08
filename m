Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVFHTr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVFHTr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFHTr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:47:27 -0400
Received: from mail.linicks.net ([217.204.244.146]:50188 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261569AbVFHTrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:47:19 -0400
From: Nick Warne <nick@linicks.net>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: mtrr question
Date: Wed, 8 Jun 2005 20:47:13 +0100
User-Agent: KMail/1.8.1
References: <200506081917.09873.nick@linicks.net> <200506082031.59987.nick@linicks.net> <20050608193556.GI876@redhat.com>
In-Reply-To: <20050608193556.GI876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506082047.13914.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 20:35, Dave Jones wrote:
> On Wed, Jun 08, 2005 at 08:31:59PM +0100, Nick Warne wrote:
>  > Ummm.  I see from boot logs that mtrr isn't detected like it is on my
>  > other (Dell) boxes.
>
> Hmm, that sounds like it isn't compiled in. Though that doesn't make
> sense why you still have a /proc/mtrr

OK, ignore my previous comment (too many Linux boxes here).  The one I am 
investigating is my main Desktop, and dmesg confirms.  mtrr is detected as 
'Intel' which is right as per the Docs (even though I have an AMD).

I also forgot to say I use the nVidia agp module (works better for me in 
Quake2 for some reason)... but searching their docs doesn't even mention 
mtrr.

Could it be that?  If so, I am wasting you guys time.

Thanks,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
