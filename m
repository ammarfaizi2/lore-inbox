Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278124AbRJLUnA>; Fri, 12 Oct 2001 16:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278128AbRJLUmu>; Fri, 12 Oct 2001 16:42:50 -0400
Received: from otter.mbay.net ([206.40.79.2]:21508 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S278124AbRJLUmd> convert rfc822-to-8bit;
	Fri, 12 Oct 2001 16:42:33 -0400
From: John Alvord <jalvo@mbay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: No love for the PPC
Date: Fri, 12 Oct 2001 13:43:02 -0700
Message-ID: <1blest8pb77m7j57e9c66a8t90gv7uov1r@4ax.com>
In-Reply-To: <Pine.LNX.4.21.0110121002200.13818-100000@asuka.nerv-9.net> <20011012105643.C30739@moonkingdom.net>
In-Reply-To: <20011012105643.C30739@moonkingdom.net>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001 10:56:43 -0700, Marc Wilson
<mwilson@moonkingdom.net> wrote:

>On Fri, Oct 12, 2001 at 10:08:39AM -0700, Mike Borrelli wrote:
>> It isn't even big problems either.  A single line (#include
>> <linux/pm.h>) is missing from pc_keyb.c and has been for at least three
>> -ac releases.  Now, process.c in arch/ppc/kernel/ dies from an undeclared
>> identifier (init_mmap).
>> 
>> Anyway, the real question is, why does the ppc arhitecture /always/ break
>> between versions?
>
>An -ac kernel is SUPPOSED to break.  It's not a release kernel.  WHEN it
>breaks, it gets fixed, and then it becomes a release kernel.
>
>Seems simple enough.

When you use a development kernel (kernel created by developers) you
have joined the test team. Breakages and bugs and failures are GOOD
things that help perfect and stabilize the products. Success reports
are interesting  but usually worthless.

john alvord
