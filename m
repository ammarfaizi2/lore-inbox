Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281800AbRKUMxI>; Wed, 21 Nov 2001 07:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281793AbRKUMw6>; Wed, 21 Nov 2001 07:52:58 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:3080 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S281775AbRKUMwt>;
	Wed, 21 Nov 2001 07:52:49 -0500
To: helgehaf@idb.hist.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
Newsgroups: linux.kernel
In-Reply-To: <3BFB7381.A0BB2474@idb.hist.no>
In-Reply-To: <20011120190316.H19738@vnl.com> <2048.1006291657@redhat.com> <20011120214705.D22590@vnl.com>
Message-Id: <20011121125244.4E9D836DE3@hog.ctrl-c.liu.se>
Date: Wed, 21 Nov 2001 13:52:44 +0100 (CET)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
>Dale Amon wrote:
>> There are a couple reasons. One that is specific to this
>> particular case is that the VeryExpensiveProprietaryPackage
>> someone bought checks the eth0 MAC address to be sure you
>> haven't moved it. It would not really be smart to license
>> it against a removable, swappable PCI card.
>> 
>Such a licencing scheme isn't very smart on a os where
>the kernel source is available anyway.

It's not very smart even on a proprietary operating system such
as Solaris.  There have been tools available to report a different
hostid on Solaris for ages.

  /Christer
-- 
"Just how much can I get away with and still go to heaven?"
