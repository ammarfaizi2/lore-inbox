Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUKHRir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUKHRir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUKHRHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:07:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18451 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261932AbUKHQbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:31:33 -0500
Date: Mon, 8 Nov 2004 17:31:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108163101.GA13234@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108161935.GC2456@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 05:19:35PM +0100, Andi Kleen wrote:
> > Rethinking it, I don't even understand the sprintf example in your 
> > changelog entry - shouldn't an inclusion of kernel.h always get it 
> > right?
> 
> Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str) transparently.

Which gcc is "Newer"?

My gcc 3.4.2 didn't show this problem.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

