Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUJLOL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUJLOL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUJLOL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:11:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30987 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263818AbUJLOLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:11:55 -0400
Date: Tue, 12 Oct 2004 16:11:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephan <support@bbi.co.bw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling linux-2.6.8.1......
Message-ID: <20041012141123.GA18579@stusta.de>
References: <006901c4b05a$3dddd570$0200060a@STEPHANFCN56VN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006901c4b05a$3dddd570$0200060a@STEPHANFCN56VN>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:51:20PM +0200, Stephan wrote:

> I'm trying to compile linux-2.6.8.1 but I'm getting the following error 
> when doing a make.
> 
>  LD      .tmp_vmlinux1
> ld: cannot open kernel/built-in.o: No such file or directory
> make: *** [.tmp_vmlinux1] Error 1
> 
> Any ideas would be apreciated.

This shouldn't be the first error.

Did you observe any other errors before?

> Kind Regards

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

