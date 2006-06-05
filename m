Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750929AbWFEX4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWFEX4t (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWFEX4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:56:49 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:43447 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750929AbWFEX4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:56:48 -0400
Message-ID: <4484C4C2.7040304@namesys.com>
Date: Mon, 05 Jun 2006 16:56:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Alexander Zarochentsev <zam@namesys.com>,
        "Barry K. Nathan" <barryn@pobox.com>, Valdis.Kletnieks@vt.edu,
        Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com> <20060605065444.GA27445@elte.hu> <20060605073701.GA28763@elte.hu> <200606051522.13698.zam@namesys.com> <20060605125029.GA5868@elte.hu>
In-Reply-To: <20060605125029.GA5868@elte.hu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to thank Ingo for designing this tool.  While it did not
find a reiser4 bug today, probably some day it will.  I hope we as a
kernel community can make automated code inspection/monitoring more and
more sophisticated over the next few years, and this is a nice little
step down that path.

Hans
