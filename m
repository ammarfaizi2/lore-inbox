Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVFHTcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVFHTcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVFHTca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:32:30 -0400
Received: from mail.linicks.net ([217.204.244.146]:59410 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261542AbVFHTcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:32:14 -0400
From: Nick Warne <nick@linicks.net>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: mtrr question
Date: Wed, 8 Jun 2005 20:31:59 +0100
User-Agent: KMail/1.8.1
References: <200506081917.09873.nick@linicks.net> <20050608192335.GG876@redhat.com>
In-Reply-To: <20050608192335.GG876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506082031.59987.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 20:23, Dave Jones wrote:

> That's odd. you should at least have write-back entries for your system
> memory. (Usually set up by the system BIOS)
>
>  > Does/is setting up mtrr per the old 1999 Docs/mtrr.txt still relevant
>  > nowadays?  I can't seem to find a definitive answer using Google.
>
> Yes, though the X driver should set them up itself on startup.

Yes, I read that, and did wonder...

Ummm.  I see from boot logs that mtrr isn't detected like it is on my other 
(Dell) boxes.

This looks like my BIOS settings are wonky then.  What would it be 'called' to 
enable/disable mtrr on an AGP slot?

Thanks,

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
