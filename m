Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266266AbRGEUO1>; Thu, 5 Jul 2001 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266267AbRGEUOR>; Thu, 5 Jul 2001 16:14:17 -0400
Received: from vitelus.com ([64.81.36.147]:62735 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S266266AbRGEUOJ>;
	Thu, 5 Jul 2001 16:14:09 -0400
Date: Thu, 5 Jul 2001 13:14:02 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Stephen C Burns <sburns@farpointer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LILO calling modprobe?
Message-ID: <20010705131401.A21275@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003201c1058c$d9161d30$4201a8c0@lan.farpointer.net>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 02:58:18PM -0500, Stephen C Burns wrote:
> Hey all,
> 
> Each time I run lilo, I receive the following message in syslog:
> 
> modprobe: Can't locate module block-major-3

I have the same problem. http://bugs.debian.org/83710
