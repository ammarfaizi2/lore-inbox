Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316493AbSEUCpP>; Mon, 20 May 2002 22:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316495AbSEUCpO>; Mon, 20 May 2002 22:45:14 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:35991 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S316493AbSEUCpN>; Mon, 20 May 2002 22:45:13 -0400
Message-ID: <3CE9B37C.8010500@linuxhq.com>
Date: Mon, 20 May 2002 22:39:56 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kurt Wall <kwall@kurtwerks.com>, linux-kernel@vger.kernel.org,
        dkegel@ixiacom.com
Subject: Re: Status of compiling 2.4 with gcc3.1?
In-Reply-To: <3CE960BC.5858E63@ixiacom.com> <20020520223125.A629@marta>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall wrote:
> Scribbling feverishly on May 20, Dan Kegel managed to emit:
> 
>>How far from wise is it to compile the 2.4.19-prex
>>kernel with gcc3.1?  Is there a list of known issues?
>>Only report of trouble I've seen so far is
>>http://groups.google.com/groups?selm=linux.kernel.5.1.0.14.2.20020515015506.02749780%40pop.cus.cam.ac.uk
>>and that's just a compile-time fatal error building ntfs.
> 
> 
> I'm running 2.4.18 built with GCC 3.1 and having no trouble that
> I've seen.
> 
> Kurt

I'm running both 2.4.19-pre8 and 2.5.16, and, though both were compiled 
with gcc 3.1, I am having no problems.

Although I remember someone saying that gcc 3.1 produced larger 
binaries, and inefficient code in some places.

Also, gcc 3.1 generates lots of warnings because of things like 
multi-line string literals, etc.

-- 
  -o)  J o h n   W e b e r
  /\\ john.weber@linuxhq.com
_\/v http://www.linuxhq.com/people/weber/

