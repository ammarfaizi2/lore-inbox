Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSKOGXZ>; Fri, 15 Nov 2002 01:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSKOGXZ>; Fri, 15 Nov 2002 01:23:25 -0500
Received: from valen.gwi.net ([207.5.128.33]:57545 "EHLO valen.gwi.net")
	by vger.kernel.org with ESMTP id <S265844AbSKOGXY>;
	Fri, 15 Nov 2002 01:23:24 -0500
Message-ID: <3DD49526.60108@goingware.com>
Date: Fri, 15 Nov 2002 01:33:10 -0500
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020622 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is much of what I hoped to do with the Linux Quality Database:

http://linuxquality.sunsite.dk/

alas, the dot-com crash happened, and I've been struggling so hard to keep my 
little business afloat that I never had enough time to devote to it.  It's good 
to see that someone has set up a bug tracking system that will be a little more 
accessible to the public than a high-traffic mailing list.

I have some suggestions about how you could improve upon bugzilla to make the 
database more useful for kernel developers.  I mention them on the page above 
and in my comment in the slashdot discussion about the new bugbase:

http://slashdot.org/comments.pl?sid=45108&cid=4675035

I didn't consider using bugzilla at first because it didn't have the 
capabilities of storing configuration info the way I wanted.  No bugbase I have 
ever used has done that, although I would consider it to be a very basic 
feature for a bug database for kernel bug tracking.  I'd meant to write a 
database app from scratch to do that, which was really more than I could 
handle.  More recently I'd been contemplating modifying bugzilla to do what I 
want, but these last few months have been really hectic.

Some have pointed out their desire for a vendor-neutral location for the bug 
database.  When I asked around about who could host it, some commercial 
companies offerred to, but I went with http://sunsite.dk/ in large part because 
they were not part of any company.

The one thing I _have_ been able to do is write some articles on kernel quality 
in particular and software quality in general.  You'll find them here:

http://linuxquality.sunsite.dk/articles/

The OSDL has been kind enough to mirror the kernel testing articles as well as 
translate them into Japanese.  I encourage others to mirror or translate my 
articles - they are all published under the GNU Free Documentation License.

Regards,

Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

     Tilting at Windmills for a Better Tomorrow.

