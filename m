Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274460AbRIYDu5>; Mon, 24 Sep 2001 23:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274457AbRIYDur>; Mon, 24 Sep 2001 23:50:47 -0400
Received: from rj.sgi.com ([204.94.215.100]:5290 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274455AbRIYDul>;
	Mon, 24 Sep 2001 23:50:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Peter Jay Salzman <p@dirac.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: report: success with agp_try_unsupported=1 
In-Reply-To: Your message of "Mon, 24 Sep 2001 14:40:06 MST."
             <20010924144006.A13695@dirac.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 13:50:56 +1000
Message-ID: <17757.1001389856@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001 14:40:06 -0700, 
Peter Jay Salzman <p@dirac.org> wrote:
>1. modprobe didn't seem to know where agpgart.o and radeon.o lives, so i had
>   to resort to insmod.  is there a way of telling modprobe where to look for
>   modules?

Probably old modutils, see Documentation/Changes and check your versions.

