Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSAISSg>; Wed, 9 Jan 2002 13:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSAISSW>; Wed, 9 Jan 2002 13:18:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37640 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288957AbSAISRs>;
	Wed, 9 Jan 2002 13:17:48 -0500
Date: Wed, 9 Jan 2002 19:17:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20020109191736.L19814@suse.de>
In-Reply-To: <20020109174926.23012.qmail@web14902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109174926.23012.qmail@web14902.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09 2002, Michael Zhu wrote:
> > 
> > This may be a troll. How would you boot? Who
> decrypts during the
> > boot?
> > 
> 
> You mean that the loop device couldn't en/decrypt the
> whole data on the disk? That mean the loop device
> could implement the block level en/decryption.

Please, read up on the loop crypto stuff off-list. Most of these
questions are very FAQ. You can loop crypto a whole disk or partition of
you want.

-- 
Jens Axboe

