Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276870AbRJCFJb>; Wed, 3 Oct 2001 01:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276871AbRJCFJV>; Wed, 3 Oct 2001 01:09:21 -0400
Received: from rj.SGI.COM ([204.94.215.100]:36781 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276870AbRJCFJR>;
	Wed, 3 Oct 2001 01:09:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Schwartz <davids@webmaster.com>
Cc: Linux-Kernel (E-mail) <linux-kernel@vger.kernel.org>
Subject: Re: Getting system time in kernel.. 
In-Reply-To: Your message of "Tue, 02 Oct 2001 22:01:41 MST."
             <20011003050142.AAA10921@shell.webmaster.com@whenever> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 15:09:32 +1000
Message-ID: <31512.1002085772@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001 22:01:41 -0700, 
David Schwartz <davids@webmaster.com> wrote:
>	As an example, a filesystem might internally store local times in its 
>inodes. You may not be free to change the on-disk format.

Whose local time?  The local time where the machine is or the local
time of the user accessing the machine from the other side of the
world?  There is a very good reason why timestamps are GMT (UTC).

