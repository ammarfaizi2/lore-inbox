Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTDTVp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTDTVp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:45:56 -0400
Received: from matrix01.home.net.pl ([212.85.112.31]:32523 "HELO
	matrix01.home.net.pl") by vger.kernel.org with SMTP id S263717AbTDTVpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:45:55 -0400
Message-ID: <3EA317F6.2000504@post.pl>
Date: Sun, 20 Apr 2003 23:58:14 +0200
From: "Leonard Milcin, Jr" <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Satchell <list@fluent2.pyramid.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: (OT) md5sum proving to be an EXCELLENT memory test
References: <6uwuhpl2u5.fsf@zork.zork.net> <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com> <6uwuhpl2u5.fsf@zork.zork.net> <5.2.0.9.0.20030420132915.01d28c40@fluent2.pyramid.net>
In-Reply-To: <5.2.0.9.0.20030420132915.01d28c40@fluent2.pyramid.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:
 > (...)
> as perfect.)  Perform md5sum on the files on the server and save the 
> results, and the signatures would be different from run to run on the 
> same files.
> 
> Incompatible RAM.
 > (...)

I had the same situation with some cheap mobo (ECS K7S5A+) of friend of 
mine. You don't need to check md5sums. Why is MD5 better than any other 
method? I just simply found, that when I copy file A to B, and then A to 
C, it is possible that B and C differs. Most of the time with one byte.

The advice is to use some good memory test suite from time to time - it 
will do better its job than you just checking signatures on large files.


Regards,

Leonard


