Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTA2NwQ>; Wed, 29 Jan 2003 08:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTA2NwQ>; Wed, 29 Jan 2003 08:52:16 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:37791 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S266120AbTA2NwQ> convert rfc822-to-8bit; Wed, 29 Jan 2003 08:52:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'Horst von Brand'" <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: AW: Bootscreen
Date: Wed, 29 Jan 2003 08:00:51 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <398E93A81CC5D311901600A0C9F29289469398@cubuss2>
In-Reply-To: <398E93A81CC5D311901600A0C9F29289469398@cubuss2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301290800.51820.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 January 2003 05:56 am, Raphael Schmid wrote:
[snip]
>
> Seriously, *laughs*, I don't think debugging user problems
> would escalate into such a scenario. Let me again point out
> my proposal:
>
> There is *one* line of boot messages shown. Whenever the
> System hangs, you will see the last message. Carefully
> designed messages will greatly help, of course.

Of course, you HAVE to suppress the new line at the end of
every line - and force a newline at the beginning of every message
... or you will only have a blank line.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
