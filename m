Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbRERWx2>; Fri, 18 May 2001 18:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbRERWxS>; Fri, 18 May 2001 18:53:18 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:50949 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S261595AbRERWxM>; Fri, 18 May 2001 18:53:12 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Mike Castle <dalgoda@ix.netcom.com>
cc: CML2 <linux-kernel@vger.kernel.org>
Message-ID: <86256A50.007D8D19.00@smtpnotes.altec.com>
Date: Fri, 18 May 2001 17:52:05 -0500
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/18/2001 at 03:56:50 PM Mike Castle <dalgoda@ix.netcom.com> wrote:

>On Fri, May 18, 2001 at 03:04:43PM -0500, Wayne.Brown@altec.com wrote:
>> 1.  Some of us are perfectly satisfied with the existing tools and don't want
>>       them to be yanked out from under us.
>
>Then stay with 2.4.x
>

Since doing kernel upgrades is my whole reason for using the tools, that's not a
very helpful suggestion.  It's a little like saying, "If you don't like the way
the air smells, just stop breathing."

>> 2.  Some of us have no interest in Python and don't like being forced to deal
>>       with installing/upgrading it just for CML2.
>
>
>Some don't like installing/upgrading the following just for a kernel:
>
>gcc
>binutils
>modutils
>mount
>Not to mention netfilter.

I don't especially like upgrading these things, either, and don't do it unless I
absolutely have to (that's why I'm still on egcs-2.91.66), but the kernel is
important enough to be worth the trouble.  If I have to use CML2 to move into
2.5.x, then I will.  However, upgrading a programming language I don't use, just
so I can replace a perfectly good tool with one I don't want, in order to do a
job that's always been easy to accomplish with the existing tools... well, that
seems a lot like a solution in search of a problem.

Fortunately, Alan's response about someone re-writing CML2 in C offers hope for
at least part of the issue.

Wayne


