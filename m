Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbRERCPv>; Thu, 17 May 2001 22:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbRERCPm>; Thu, 17 May 2001 22:15:42 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:30748 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S262235AbRERCPd>;
	Thu, 17 May 2001 22:15:33 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Joel Cordonnier <jocordonnier@yahoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: newbie problem: compiling kernel 2.4.4, make modules_install , Help please ! 
In-Reply-To: Your message of "Thu, 17 May 2001 20:50:46 +0200."
             <20010517185046.353.qmail@web13703.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 May 2001 12:15:23 +1000
Message-ID: <24420.990152123@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001 20:50:46 +0200 (CEST), 
Joel Cordonnier <jocordonnier@yahoo.fr> wrote:
>It's the first time that i try to compile my own
>kernel. At the moment, I have an old RH 6.1 with a
>2.2.12 kernel.
>- make modules_install ==> PROBLEM !
>FIRST the message say that no argument -F exist for
>the command /sbin/depmod.

Always read Documentation/Changes and check that *all* your utilities
are up to date before working on a new kernel.

