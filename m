Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315663AbSECTUP>; Fri, 3 May 2002 15:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315665AbSECTUO>; Fri, 3 May 2002 15:20:14 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:16650 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315663AbSECTUN>;
	Fri, 3 May 2002 15:20:13 -0400
Message-Id: <200205032022.PAA04244@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was Discontigmem virt_to_page() ) 
In-Reply-To: Your message of "Fri, 03 May 2002 15:01:48 -0400."
             <Pine.LNX.3.95.1020503144728.8291A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 15:22:57 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@chaos.analogic.com said:
> Would you please tell me what Unix has 32-bit address space which is
> not shared with the kernel? 

I'm planning on doing that with UML at some point.

The claim that it's not Unix if it doesn't share the process address space
is just stupid.

				Jeff

