Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTDNWxY (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTDNWxY (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:53:24 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:62616 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263979AbTDNWxX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:53:23 -0400
Subject: Re: kernel support for non-English user messages
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Bradford <john@grabjohn.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050361497.677.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 15 Apr 2003 01:04:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 19:29, Linus Torvalds wrote:
> Some people care about documentation, some people don't. That's a fact,
> and spouting platitudes about "improving their work" just doesn't
> _matter_. The whole open source idea is that people do what they care 
> about and what they are good at, and exactly because they aren't forced to 
> deal with issues they don't have a heart for they take  more pride and 
> interest in the stuff they _do_ do.

Newbies as me do care about documentation ;-) The Linux kernel is
getting more complex over time, and I appreciate some kind of
architectural docs to know more about the inner workings. Personally, I
don't have all the time I would like to explore and investigate, so a
50,000-feet-point-of-view and some detailed documentation about VM,
scheduler and net are welcome.

Kernel experts as you (Linus, Andrew, Alan, Russell, Jeff and many
others whose names I must leave out as I don't have space to name them
all) probably know the inner workings better than anyone as they work
with it every day, but people new to kernel hacking need some starting
point.

> Personally, I don't write documentation. I don't much even write comments
> in my code. My personal feeling is that as long as functions are small and
> readable (and logical), and global variables have good names, that's all I
> need to do. Others - who do care about comments and docs - can do that
> part.

Well, some functions and variable names may seem readable and logical to
some, but it takes time for me to decipher some of them :-)

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

