Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283449AbRK3AnZ>; Thu, 29 Nov 2001 19:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283446AbRK3AnP>; Thu, 29 Nov 2001 19:43:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4850 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283447AbRK3AnF>; Thu, 29 Nov 2001 19:43:05 -0500
Message-ID: <3C06D61D.2000803@us.ibm.com>
Date: Thu, 29 Nov 2001 16:43:09 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011128
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alex Valys <avalys@optonline.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Spinlock Macro Arguments Correction in pc_keyb.c
In-Reply-To: <0GNL00C2J5G9JN@mta6.srv.hcvlny.cv.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Valys wrote:

>Not having ever done any serious kernel programming, I have only a dim 
>understanding of what spinlocks are, but by looking at those macro 
>definitions in spinlock.h (and their occurences elsewhere in the file) I 
>think I determined their proper usage.  The following patch fixed the compile 
>errors, and I'm using 2.5.1-pre3 to type this message.  
>
>This is my first patch, so if I did anything wrong please correct me.
>-Alex Valys
>
That looks like an error as a result of one of my patches.  Your 
solution looks correct.  Make sure to send it over to Linus.  Nice job 
with your first patch!

David C. Hansen
haveblue@us.ibm.com

