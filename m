Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSAZA7z>; Fri, 25 Jan 2002 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288975AbSAZA7p>; Fri, 25 Jan 2002 19:59:45 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:45065
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S288971AbSAZA7d>; Fri, 25 Jan 2002 19:59:33 -0500
Message-Id: <5.1.0.14.2.20020125195046.01dab0e0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 25 Jan 2002 19:55:05 -0500
To: "James Stevenson" <mistral@stev.org>,
        "Tony Glader" <Tony.Glader@blueberrysolutions.com>,
        <linux-kernel@vger.kernel.org>
From: Stevie O <stevie@qrpff.net>
Subject: Re: F00F-bug workaround working?
In-Reply-To: <03ce01c19c87$cfcf4570$0801a8c0@Stev.org>
In-Reply-To: <Pine.LNX.4.33.0201122347270.16871-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:11 PM 1/13/2002 +0000, James Stevenson wrote:


>the foof bug would cause the system to hang. not to panic.
>

If I'm not mistaken (and I probably am), the F00F bug causes the proc to 
screw  up the handling of an invalid instruction.  I.E. no legitimate 
program would possibly cause this, only hand-written bytecode (or, 
theoretically, a stack overflow overwriting a return address to point to 
data) can cause this.

So unless someone's trying to mess with you, I doubt F00F is affecting you.

http://x86.ddj.com/errata/dec97/f00fbug.htm




--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

