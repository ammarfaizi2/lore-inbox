Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291838AbSBAQXX>; Fri, 1 Feb 2002 11:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291828AbSBAQXO>; Fri, 1 Feb 2002 11:23:14 -0500
Received: from kanalen.org ([195.54.149.2]:1002 "EHLO neverland.kanalen.org")
	by vger.kernel.org with ESMTP id <S291827AbSBAQXD>;
	Fri, 1 Feb 2002 11:23:03 -0500
Message-Id: <200202011622.g11GMpp23713@neverland.kanalen.org>
Content-Type: text/plain; charset=US-ASCII
From: Tommy Johansson <tommy.johansson@kanalen.org>
To: "Anish Srivastava" <anish@bidorbuyindia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Java for Linux
Date: Fri, 1 Feb 2002 17:30:53 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <005201c1aae9$2215cb00$3c00a8c0@baazee.com>
In-Reply-To: <005201c1aae9$2215cb00$3c00a8c0@baazee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can anyone guide me in choosing the appropriate port of Java for Linux
> 2.4.17 and glibc-2.2.2-10
> Which is the best of the three?
> Blackdown Java
> IBM JAVA
> Sun Java

I have done quite a few tests with all major java vm's and IBM is always the 
fastest. The only problem is that IBM is a bit behind in vm versions. SUN is 
1.3.1 and 1.4 is in RC status, while IBM is still at 1.3.

> I have heard that Blackdown supports native threads...while IBM and SUN do
> not!!

No! all, at least from 1.3 and onwards, support native threads.

/Tommy
