Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280808AbRKYKY6>; Sun, 25 Nov 2001 05:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280809AbRKYKYt>; Sun, 25 Nov 2001 05:24:49 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15623 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280808AbRKYKYf>;
	Sun, 25 Nov 2001 05:24:35 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Nathan Dabney <smurf@osdlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases 
In-Reply-To: Your message of "Sun, 25 Nov 2001 01:25:07 -0800."
             <20011125012507.C6414@osdlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Nov 2001 21:24:21 +1100
Message-ID: <12023.1006683861@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001 01:25:07 -0800, 
Nathan Dabney <smurf@osdlab.org> wrote:
>We will be running all the available tests (until that list gets too large
>to be possible) on each kernel the morning after it's released.

Have you been following the kbuild 2.5 developments[1]?  Linus has
agreed that this change will go in early in the 2.5 cycle, that will
impact on all automated testing for 2.5.  There will be both good and
bad impacts, the bad is the initial changeover, the good is a much
cleaner build process and the ability to build multiple configurations
from a single source tree.

[1] http://sourceforge.net/projects/kbuild/

