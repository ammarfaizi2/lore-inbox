Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310424AbSCPQ3d>; Sat, 16 Mar 2002 11:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCPQ3X>; Sat, 16 Mar 2002 11:29:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310424AbSCPQ3N>;
	Sat, 16 Mar 2002 11:29:13 -0500
Message-ID: <3C9372BE.4000808@mandrakesoft.com>
Date: Sat, 16 Mar 2002 11:28:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>jgarzik@mandrakesoft.com said:
>
>>Through the magic of BK :)
>>
>
>>Just do a 'bk pull' on my marcelo-2.4 tree.  Since it is based on the
>>original linux-2.4 tree just like Marcelo's tree, I was able to merge
>>from my 2.4 line to his 2.4 line. 
>>
>
>Well, I tried this, but it just gave me a slew of initial rename conflicts.  
>

This is normal, you just need to accept the remote changes for all those 
new/renamed files.  BitKeeper doesn't support doing this automatically 
for all files, so I had to highlight the expected BitKeeper response in 
another window, and then click <paste> on my mouse around 300 times... 
(~300 new files)

    Jeff






