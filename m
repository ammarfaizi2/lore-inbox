Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbTAGJIc>; Tue, 7 Jan 2003 04:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTAGJIc>; Tue, 7 Jan 2003 04:08:32 -0500
Received: from lakemtao03.cox.net ([68.1.17.242]:3457 "EHLO lakemtao03.cox.net")
	by vger.kernel.org with ESMTP id <S267349AbTAGJIc>;
	Tue, 7 Jan 2003 04:08:32 -0500
Message-ID: <3E1A9AF7.8030503@cox.net>
Date: Tue, 07 Jan 2003 03:16:39 -0600
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Valdez <maxvaldez@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ??
References: <1041911922.29225.1.camel@garaged.fis.unam.mx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Valdez wrote:
> Is there any way to revert the stupid mistyping of "rm file *" on ext3??
> 
> I hope there is a way, because I dont have a backup of some files i
> mistakenly deleted
> 
> Any help appreciated!
> Thanks
> Max

Try e2undel on sourceforge. You MIGHT be able to recover something. I 
think. Good luck regardless.

-David

