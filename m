Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRK0Jvf>; Tue, 27 Nov 2001 04:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRK0JvY>; Tue, 27 Nov 2001 04:51:24 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:6148 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S274789AbRK0JvM>; Tue, 27 Nov 2001 04:51:12 -0500
Message-ID: <3C0361D1.A4EA110F@idb.hist.no>
Date: Tue, 27 Nov 2001 10:50:09 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
In-Reply-To: <Pine.LNX.3.96.1011126151758.27112G-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Sun, 25 Nov 2001, David Relson wrote:
> 
> I wish you luck. About 18 months ago I offered to set up a testing group
> to take kernel source before it with up for ftp and to compile it on
> various x86, SPARC{32,64}, and ALPHA machines to be sure it would at least
> compile. I was told with varying degrees of rudeness that it would delay
> the releases (that is a GOOD thing in stable kernels), and that I should
> avoid the 2.4 series and use the "stable" 2.2 kernsls (2.4 IS a stable
> kernel of course, although you would never gues it).
> 

Nobody's against you running a compile-test setup.  What they don't like
is the part about not releasing it until you have tested it.
That's because many others want to test too!
This is necessary - some may test aspects other than mere compiling.
Or perhaps a compiler different from yours.

Feel free to serve "known good" kernels - the masses who don't read
changelogs
or don't want to risk possible new bugs will surely appreciate this.

Just don't limit those of us who want to test the very latest - even
kernels with known bugs.  Maybe the bug won't bother me because I
don't use that driver/fs and things like that.  I want the kernel even
if, say, minixfs is broken.

Downloading the latest kernel is _not_ for those who can't deal
with occational trouble.  
Pre or no pre - development or "stable" series.
Those who run the latest is the testing team.  If they don't want to
be, they go for kernels at least a couple of weeks old that haven't
gathered trouble reports.  

Helge Hafting
