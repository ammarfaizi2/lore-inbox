Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSJSXUE>; Sat, 19 Oct 2002 19:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSJSXUE>; Sat, 19 Oct 2002 19:20:04 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:10982 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265705AbSJSXM5>; Sat, 19 Oct 2002 19:12:57 -0400
Message-ID: <3DB1E876.2000302@quark.didntduck.org>
Date: Sat, 19 Oct 2002 19:19:18 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Christian Borntraeger <linux@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
References: <Pine.LNX.4.10.10210191550060.24031-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
 > On Sat, 19 Oct 2002, Brian Gerst wrote:
 >
 >
 >>Andre Hedrick wrote:
 >>
 >>>So could you ask the question a little more blunt?
 >>>
 >>>"Gee, I am trying to break a US Law on content protection, would you 
be my
 >>>enabler?  Don't worry, it only effects the US, and we are in a public
 >>>forum.  Also, do you prefer gray or black in your future pin stripped
 >>>suit?"
 >>
 >>Attempting to read a "defective" disc should never, ever, cause a kernel
 >>oops.  Whether it succeeds or not is irrelevant.
 >
 >
 > Please point out where in the original post, the referrence to 
"defective"
 > media.  If this would have been the case, your point it valid.  If I
 > missed something, thus am wrong, I will admit to being wrong.

Copy-protected discs abuse the CD standards to the point where CDROM
drives consider them defective and can't/won't read them, while less
intelligent devices can.  Trying to read one of these discs should only 
cause the kernel to return an error, never an oops.

--
				Brian Gerst


