Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131981AbRBKHdB>; Sun, 11 Feb 2001 02:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131948AbRBKHcv>; Sun, 11 Feb 2001 02:32:51 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:55300 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S132006AbRBKHco>; Sun, 11 Feb 2001 02:32:44 -0500
Message-ID: <3A86387B.D3142DD9@namesys.com>
Date: Sun, 11 Feb 2001 10:00:11 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Daniel Stone <daniel@kabuki.eyep.net>
CC: Chris Wedgwood <cw@f00f.org>, Chris Mason <mason@suse.com>,
        David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        Chris Mason <mason@suse.com>, Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <479040000.981564496@tiny>
		<E14QkfM-0004EL-00@piro.kabuki.eyep.net> 
		<20010211020200.A9570@metastasis.f00f.org> <E14RZiG-0001s1-00@piro.kabuki.eyep.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Stone wrote:
> 
> On 11 Feb 2001 02:02:00 +1300, Chris Wedgwood wrote:
> > On Thu, Feb 08, 2001 at 05:34:44PM +1100, Daniel Stone wrote:
> >
> >     I run Reiser on all but /boot, and it seems to enjoy corrupting my
> >     mbox'es randomly.
> >
> > what kind of corruption are you seeing?
> 
> Zeroed bytes.

This sounds like the same bug as the syslog bug, please try to help Chris
reproduce it.

zam, if Chris can't reproduce it by Monday, please give it a try.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
