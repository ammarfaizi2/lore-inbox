Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSEPWwi>; Thu, 16 May 2002 18:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSEPWwh>; Thu, 16 May 2002 18:52:37 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:18186 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315179AbSEPWwh>;
	Thu, 16 May 2002 18:52:37 -0400
Date: Thu, 16 May 2002 15:52:35 -0700
From: Greg KH <greg@kroah.com>
To: Christer Nilsson <christer.nilsson@kretskompaniet.se>
Cc: lepied@xfree86.org, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.19-pre8  Fix for Intuos tablet in wacom.c
Message-ID: <20020516225235.GE1952@kroah.com>
In-Reply-To: <20020515024646.GA21582@kroah.com> <IBEJLIFNGHPKEKCKODPDIEFFDPAA.christer.nilsson@kretskompaniet.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 18 Apr 2002 21:33:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 10:54:18AM +0200, Christer Nilsson wrote:
> Yes, when you removed the smoothing algorithm you forgot to make
> the change my previous patch fixed. Anyway, I took a look at the code
> and found that it could be cleaned up a little.
> This patch works for me, but I can only test it with an Intuos tablet
> although it should not break anything.

Thanks, I've added this to my tree, and I'll send it out in the next
round of patches.

greg k-h
