Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318741AbSHBHUm>; Fri, 2 Aug 2002 03:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318746AbSHBHUm>; Fri, 2 Aug 2002 03:20:42 -0400
Received: from ds217-115-144-18.dedicated.hosteurope.de ([217.115.144.18]:60938
	"EHLO mail.crapoud.com") by vger.kernel.org with ESMTP
	id <S318741AbSHBHUl>; Fri, 2 Aug 2002 03:20:41 -0400
Message-ID: <3D4A3396.9000500@crapoud.com>
Date: Fri, 02 Aug 2002 09:24:06 +0200
From: "Hartwig. Thomas" <t.hartwig@crapoud.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday clock jump bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was referenced to a gettimeofday problem spoken of in the kernel 
discussion summary:
http://kt.zork.net/kernel-traffic/kt20020708_174.html#1

There is spoken of .01% reproducibility and less of this problem.

I got to this problem here running a version of GNU wget (1.8.2) and 
following kernel: Linux version 2.4.18 (gcc version 2.96 20000731 (Red 
Hat Linux 7.3 2.96-110)) #4 Sun Jul 28 09:01:06 CEST 2002

In this configuration I get the error even more times. In 2300 calls I 
get 319 failures, this is something about 0.07% not too much, but 
significant.

However it is not my skill to analyze nor get to deep in wget and the 
kernel. It's just a note and a offer of some further tests if you need.

Greetings
Thomas

PS: I'm sorry this message is out of the thread index. I got to late on 
the list.


