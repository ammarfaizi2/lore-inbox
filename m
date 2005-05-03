Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVECQZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVECQZb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVECQZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:25:30 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:51085 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261207AbVECQYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:24:22 -0400
Message-ID: <4277A0A8.3010101@tmr.com>
Date: Tue, 03 May 2005 12:02:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
CC: Valdis.Kletnieks@vt.edu, Adrian Bunk <bunk@stusta.de>,
       Ed Tomlinson <tomlins@cam.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
References: <200505021528.j42FS5QJ006515@turing-police.cc.vt.edu><200505021528.j42FS5QJ006515@turing-police.cc.vt.edu> <4276AC90.30008@tuxrocks.com>
In-Reply-To: <4276AC90.30008@tuxrocks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Valdis.Kletnieks@vt.edu wrote:
> 
>>And even *more* importantly, note that when downloading a -mm or -rc3 patch,
>>there's minimal server overhead - it opens *one* file and streams it to the
>>FTP connection.  sendfile() anybody? ;)
> 
> 
> Also, note that once I've downloaded the single .bz2 file, I can easily
> copy or move it to the various computers I'll be compiling and
> installing it on.  It's much easier to transfer the one file (via USB
> memory  stick, SCP, CD, etc.) than a whole tree.

Is someone really suggesting that SCC will replace the current tar and 
patch files? I think it is more a question of "what will replace bk long 
term" than what will be the one and only tool. None of the SCC systems 
is going to replace the single file source and patch, they don't server 
the same purpose.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

