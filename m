Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314422AbSEBNyk>; Thu, 2 May 2002 09:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314439AbSEBNyj>; Thu, 2 May 2002 09:54:39 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:18678 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314422AbSEBNyi>; Thu, 2 May 2002 09:54:38 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3CD134B6.6090504@evision-ventures.com> 
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 May 2002 14:54:24 +0100
Message-ID: <14420.1020347664@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dalecki@evision-ventures.com said:
>  No I was consciuous: I just saw some macro preprocessing clashes. 

But not conscious enough to bother to Cc the maintainer or explain the 
clashes you saw?

Do what you like; I'm ignoring 2.5 until Marcelo gets 2.4.19 out and I can
send him the rest of the code I'm sitting on for 2.4.20-pre1; at which point
I'll update everything in my tree to build against 2.5 and require magic in
compatmac.h for the 2.4 build, and I'll look at what's changed then.

--
dwmw2


