Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292357AbSBBTQn>; Sat, 2 Feb 2002 14:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292356AbSBBTQe>; Sat, 2 Feb 2002 14:16:34 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:60411 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S292355AbSBBTQO>; Sat, 2 Feb 2002 14:16:14 -0500
Date: Sat, 2 Feb 2002 19:16:07 +0000
From: Anthony Campbell <ac@acampbell.org.uk>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeated lockups caused by ext3?
Message-ID: <20020202191607.GA3827@debian.local>
In-Reply-To: <20020201162055.GA1318@debian.local> <20020202002353.N5808@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020202002353.N5808@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Feb 2002, Matti Aarnio wrote:
> 
>   Oh dear..  uniprocessor ?
>   I get SMP machine to hang when writing 1+ GB file to EXT3 on RAID-1, and 
>   having more than 512 MB memory...
> 

This certainly sounds as if it might be relevant. In my case it only
occurs with long downloads, not with mail. And it hasn't happened at all
since turning off ext3.

Anthony

-- 
Anthony Campbell - running Linux GNU/Debian (Windows-free zone)
For an electronic book (The Assassins of Alamut), skeptical 
essays, and over 150 book reviews, go to: http://www.acampbell.org.uk/

Our planet is a lonely speck in the great enveloping cosmic dark. In our
obscurity, in all this vastness, there is no hint that help will come
from elsewhere to save us from ourselves. [Carl Sagan]



