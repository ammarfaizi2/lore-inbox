Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbTATVFt>; Mon, 20 Jan 2003 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbTATVFs>; Mon, 20 Jan 2003 16:05:48 -0500
Received: from mail.webmaster.com ([216.152.64.131]:54153 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266972AbTATVFr> convert rfc822-to-8bit; Mon, 20 Jan 2003 16:05:47 -0500
From: David Schwartz <davids@webmaster.com>
To: <adilger@clusterfs.com>
CC: <david.lang@digitalinsight.com>, <dana.lacoste@peregrine.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Mon, 20 Jan 2003 13:14:47 -0800
In-Reply-To: <20030120134831.Q1594@schatzie.adilger.int>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030120211449.AAA797@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 13:48:31 -0700, Andreas Dilger wrote:

>So, let's say that CVS is the "preferred form" of the Linux kernel
>source code, because it is freely available.  If BK has everything 
>in it that CVS does, and also information that is not even POSSIBLE 
>to store in CVS (i.e. ChangeSet information which links a bunch of 
>individual file changes and comments into a single change entity) 
>what happens then?  If you had never put the kernel into BK, that 
>information wouldn't exist at all, yet
>it is not possible to extract it without resorting to some 
>source-of-all- evil
>tool like BK (I hope everyone reading here understands the sarcasm,
>but the fact that I have to annotate it makes me believe some people 
>will not).

	If CVS is the "preferred form", then it is CVS you must distribute. 
What other tools provide what other information is irrelevant. The 
GPL is quite clear that the preferred form of the source for making 
modifications is what you must distribute.

>The fact that BK is used creates information which WOULD NOT HAVE
>EXISTED
>had BK not existed.  In fact, until BK was in use by Linus, not even
>basic
>CVS checkin comments existed, so the metadata was in a format called
>linux-kernel mbox (if that).  So, the use of a tool like BK makes
>more data
>available, but people cannot be worse off than when the kernel was
>shipped
>as a tarball and periodic patches.  For the sake of those people who
>don't
>or can't use BK, just pretend BK doesn't exist and they will not be
>any
>worse off than a year ago.

	The GPL doesn't care about whether you're better off or worse off. 
The GPL just says you have to distribute the source in its preferred 
form for making modifications.

>>I submit that it is impossible to comply with the GPL and
>>distribute
>>binaries if the preferred form of a work for the purposes of making
>>modifications to it is in a proprietary file format. This is
>>tantamount to encrypting the source.

>Sure, except BK isn't a proprietary file format (see GNU CSSC and or
>some
>Perl scripts reported on this list), so the issue is purely
>hypothetical.

	It sounds like you and I are in violent agreement. But it's not 
purely hypothetical -- there are GPL projects today that keep their 
source in proprietary file formats. (For example, many of the ones 
using Visual C++.)

	DS


