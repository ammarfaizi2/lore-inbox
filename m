Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTDJR3U (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTDJR3U (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:29:20 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:21953 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S264113AbTDJR3T (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 13:29:19 -0400
Message-ID: <3E95AF4F.20105@kegel.com>
Date: Thu, 10 Apr 2003 10:52:15 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: wd@denx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95 broken on PPC?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Denkster wrote:
>> However, bugs #1 (zlib.c) and #3 (div64.h) disappear if I compile
>> my kernels with gcc-3.2.2 instead of 2.95.4, which is a strong
>> indication that 2.95.4 is broken on PPC. Is this something that's
> 
> This is speculation only. We use gcc-2.95.4 as part of  our  ELDK  in
> all  of our projects, and a lot of people are using these tools, too.
> We definitely see more problems with gcc-3.x compilers.

Hi Wolfgang, when you say you see more problems with gcc-3.x
compilers, what is x?  I'd understand if you saw problems
with gcc-3.0.*, but I had hoped that gcc-3.2.2 would compile
good kernels for ppc.
(Me, I'm still using Montavista Linux 2.0's gcc-2.95.3 to build my ppc kernels,
but am looking for an excuse to switch to gcc-3.2.* or gcc-3.3.*.)
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

