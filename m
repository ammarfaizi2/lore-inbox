Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290789AbSAYSv5>; Fri, 25 Jan 2002 13:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSAYSvj>; Fri, 25 Jan 2002 13:51:39 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47885 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290787AbSAYSuH>; Fri, 25 Jan 2002 13:50:07 -0500
Message-ID: <3C51A7EE.1010108@namesys.com>
Date: Fri, 25 Jan 2002 21:46:06 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: John Levon <movement@marcelothewonderpenguin.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
In-Reply-To: <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing a large set of patches (each to be sent as a separate 
email per your SOP, but all tested together in a thorough testing 
procedure), which includes this patch, plus the kdev fix, plus all 2.4 
fixes.  We expect to send it out on monday, we just found a bug in the 
patches as a set that was not present in them individually.

Hans


