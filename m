Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269779AbRHYRFV>; Sat, 25 Aug 2001 13:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269795AbRHYRFL>; Sat, 25 Aug 2001 13:05:11 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:58629 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S269779AbRHYRFB>; Sat, 25 Aug 2001 13:05:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Strange login problems with recent -ac kernels
In-Reply-To: <9m8j3i$7m$1@ns1.clouddancer.com>
In-Reply-To: <20010825070117.A8826@bessie.localdomain> <9m8j3i$7m$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010825170517.17AC7783EE@mail.clouddancer.com>
Date: Sat, 25 Aug 2001 10:05:17 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, Jim wrote:
>
>    Recently when I login to the first virtual console, I will sometimes get
>a message like this:
>
>    bessie login: jlnance
>    Last login: Fri Aug 24 12:37:18 from hazard
>    Warning: no access to tty (Inappropriate ioctl for device).
>    Thus no job control in this shell.
>
>The only thing that has changed recently has been the kernels, so I assume
>that it has something to do with them.  Right now I am running 2.4.8-ac9 but
>it also happened with -ac7.  I dont remember ever seeing it before that.
>It does not happen every time, and it seems to only occur on the ctrl-alt-F1
>vitrual console.  Does anyone have any ideas?

I've been seeing that message pop up in xterms whenever root has su'ed
to some username over several kernel versions (probably back into
2.4.4).  Job control has always been fine and I've never noticed any
problems.  Perhaps our login utilities are out of date.


-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

