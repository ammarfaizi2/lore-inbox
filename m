Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTAKGVC>; Sat, 11 Jan 2003 01:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbTAKGVC>; Sat, 11 Jan 2003 01:21:02 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:36832 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S267094AbTAKGVB>; Sat, 11 Jan 2003 01:21:01 -0500
Message-ID: <3E1FBDF8.7000904@kegel.com>
Date: Fri, 10 Jan 2003 22:47:20 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: NGPT 2.2.0 RELEASED: TOPS LINUXTHREADS AND NPTL IN SCALABILITY
 AND PERFORMANCE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Jan 2003 20:33:46 EST, Jeff Garzik said:
>> On Fri, Jan 10, 2003 at 05:26:47PM -0800, jjs wrote:
>> > But according to my understanding, a more accurate
>> > measure of nptl performance would require a current
>> > glibc, with the nptl-specific enhancements -
>> > 
>> > or am I missing something here?
>> 
>> You are correct:  you need a recent 2.5 kernel and a recent glibc.
> 
> I'll bite - how recent a glibc?  Does the 2.3.1 RPM that RedHat included
> on the Phoebe beta qualify, or do we need even more bleeding-edge?

https://listman.redhat.com/pipermail/phil-list/2003-January/000413.html
lists what sources are needed for the latest nptl.
Phoebe beta had a slightly earlier snapshot of nptl and glibc.

As far as the kernel goes, it's rumored
( https://listman.redhat.com/pipermail/phil-list/2003-January/000419.html )
that you're better off using a recent 2.5 kernel than the 2.4 backport
in phoebe.

I haven't tried NPTL myself, though, so what do I know...
- Dan

-- 
Dan Kegel
Linux User #78045
http://www.kegel.com

