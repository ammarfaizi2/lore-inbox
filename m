Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSEEXpF>; Sun, 5 May 2002 19:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313882AbSEEXpE>; Sun, 5 May 2002 19:45:04 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17670 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313867AbSEEXpD>;
	Sun, 5 May 2002 19:45:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: dank@kegel.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Sun, 05 May 2002 09:42:35 MST."
             <3CD560FB.C6736001@kegel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 09:44:53 +1000
Message-ID: <8473.1020642293@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2002 09:42:35 -0700, 
Dan Kegel <dank@kegel.com> wrote:
>Keith also says:
>> I am temporarily omitting [modversions] which is (a) currently broken
>> (b) is not being used in development kernels and (c) cannot be fixed
>> without a radical redesign.  Modversions is not needed right now and
>> will be added later.  Everything I have done in kbuild 2.5 is needed
>> now
>
>[Caveat: I'm not much of a kernel hacker.]
>My only concern with kbuild 2.5 was the lack of modversions,
>but since Richard is promising to add them in before the
>distros need them,

You misquoted.  Richard is not promising to add modversions, I am.
I maintain both kbuild and modutils, the two halves of the modversion
problem.

