Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268549AbTBWVDh>; Sun, 23 Feb 2003 16:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbTBWVDh>; Sun, 23 Feb 2003 16:03:37 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13828 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268549AbTBWVDg>; Sun, 23 Feb 2003 16:03:36 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302232115.h1NLF9wo000201@81-2-122-30.bradfords.org.uk>
Subject: Re: Minutes from Feb 21 LSE Call
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 23 Feb 2003 21:15:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b3b6oa$bsj$1@penguin.transmeta.com> from "Linus Torvalds" at Feb 23, 2003 07:17:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >If I didn't know this mattered I wouldn't bother with the barfbags.
> >I just wouldn't deal with it.
> 
> Why?
> 
> The x86 is a hell of a lot nicer than the ppc32, for example.  On the
> x86, you get good performance and you can ignore the design mistakes (ie
> segmentation) by just basically turning them off.

I could be wrong, but I always thought that Sparc, and a lot of other
architectures could mark arbitrary areas of memory, (such as the
stack), as non-executable, whereas x86 only lets you have one
non-executable segment.

John.
