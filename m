Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTKTV5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTKTV5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:57:36 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:10515 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S262902AbTKTV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:57:35 -0500
Message-ID: <3FBD37B5.3090500@techsource.com>
Date: Thu, 20 Nov 2003 16:52:53 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@cela.pl>
CC: Andreas Dilger <adilger@clusterfs.com>,
       Justin Cormack <justin@street-vision.com>,
       Jesse Pollard <jesse@cats-chateau.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
References: <Pine.LNX.4.44.0311202249150.10515-100000@gaia.cela.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Maciej Zenczykowski wrote:
>>It is, though.  If you run out of space copying a file, you know it when 
>>you're copying.  Applications don't usually expect to get out-of-space 
>>errors while overwriting something in the middle of a file.
> 
> 
> What about sparse files?


Ah, good point.  Never mind.  :)


