Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRAXNBc>; Wed, 24 Jan 2001 08:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRAXNBX>; Wed, 24 Jan 2001 08:01:23 -0500
Received: from hermes.mixx.net ([212.84.196.2]:15116 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130153AbRAXNBK>;
	Wed, 24 Jan 2001 08:01:10 -0500
Message-ID: <3A6ED16E.E8343678@innominate.de>
Date: Wed, 24 Jan 2001 13:58:22 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <3A6C5058.C5AA7681@zaralinux.com> <3A6CB620.469A15A9@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> This is not a kernel bug, This is a bug in the XFree86 TrueType rendering
> extention. This has been discussed on the Xpert XFree86 mailing list. There
> is a fix in the works (depends on the TrueType fonts your using).

A BUG is a BUG:
 
> > kernel BUG at slab.c:1542!

The kernel should never oops, no matter what user space does to it.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
