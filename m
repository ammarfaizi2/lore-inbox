Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264894AbRFTPNF>; Wed, 20 Jun 2001 11:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264895AbRFTPMz>; Wed, 20 Jun 2001 11:12:55 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:50123 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264894AbRFTPMj>;
	Wed, 20 Jun 2001 11:12:39 -0400
Message-ID: <3B30BD5D.153A5FE9@candelatech.com>
Date: Wed, 20 Jun 2001 08:12:29 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <20010620042544.E24183@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> On Wed, Jun 20, 2001 at 09:00:47AM +0000, Henning P. Schmiedehausen wrote:
> > Just the fact that some people use Java (or any other language) does
> > not mean, that they don't care about "performance, system-design or
> > any elegance whatsoever" [2].
> 
> However, the very concept of Java encourages not caring about
> "performance, system-design or any elegance whatsoever". If you cared

System-design and elegance are easy to get
in Java, and in fact are independent of language.  Good c code will beat
Java in most cases, performance wise, but lately the difference has become
small enough not to matter for most applications.  Speed is not the most
important feature in a great many programs, otherwise we'd all be using
assembly still.

> about any of those things you would compile to native code (it exists
> for a reason). Need run-anywhere support? Distribute sources instead.

When was the last time you wrote a large cross-platform GUI that just
worked on other platforms, without any additional tweaking, after you
developed it on your Linux machine?

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
