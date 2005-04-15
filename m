Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVDOSkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVDOSkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVDOShi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:37:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53193 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261893AbVDOSgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:36:19 -0400
Subject: Re: Kernel Rootkits
From: Lee Revell <rlrevell@joe-job.com>
To: Allison <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17d79880504151115744c47bd@mail.gmail.com>
References: <17d79880504151115744c47bd@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 14:36:16 -0400
Message-Id: <1113590176.23659.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 18:15 +0000, Allison wrote:
> Once these are loaded into the kernel, is there no way the kernel
> functions can be protected ?

No.  If the attacker can load arbitrary code into the kernel, game over.
Think about it.

Lee

