Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283908AbRLAD0L>; Fri, 30 Nov 2001 22:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283907AbRLAD0B>; Fri, 30 Nov 2001 22:26:01 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:25094 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283905AbRLADZw>;
	Fri, 30 Nov 2001 22:25:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Garst R. Reese" <reese@isn.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: small feature request 
In-Reply-To: Your message of "Fri, 30 Nov 2001 20:23:07 EDT."
             <3C0822EB.3E4C4852@isn.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Dec 2001 14:25:40 +1100
Message-ID: <11596.1007177140@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001 20:23:07 -0400, 
"Garst R. Reese" <reese@isn.net> wrote:
>Would it possible to put a header on System.map indicating the kernel
>version?
>Sometimes my little brain forgets what kernel System.old is for.

It is on my list for kbuild 2.5, once I start on the new design for
reconciling kernel and modules.  Goodbye modversions, hello "something
that works" (I hope).

