Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSDIOCf>; Tue, 9 Apr 2002 10:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSDIOCe>; Tue, 9 Apr 2002 10:02:34 -0400
Received: from [203.117.131.12] ([203.117.131.12]:41687 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S293060AbSDIOCd>; Tue, 9 Apr 2002 10:02:33 -0400
Date: Tue, 9 Apr 2002 22:02:26 +0800
Subject: Re: C++ and the kernel
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        "T. A." <tkhoadfdsaf@hotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: root@chaos.analogic.com
From: Michael Clark <michael@metaparadigm.com>
In-Reply-To: <Pine.LNX.3.95.1020409085537.4291B-100000@chaos.analogic.com>
Message-Id: <6C5F2A43-4BC2-11D6-BFB0-000393843900@metaparadigm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, April 9, 2002, at 09:28 PM, Richard B. Johnson wrote:

> C++ is designed for user-mode programming. It expects to interface
> with a complete operating system with well-defined characteristics.
> It is not designed to be part of an operating system kernel.

Not according to Apple.

http://developer.apple.com/techpubs/macosx/Darwin/IOKit/iokit.html

"The I/O Kit is a collection of system frameworks, libraries, tools,
and other resources for creating device drivers in Mac OS X. It is
based on an object-oriented programming model implemented in a
restricted form of C++ that omits features unsuitable for use within
a multithreaded kernel."

Although I wouldn't use this as a justification for doing this
in Linux ;).

~mc

