Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265112AbRFZV1T>; Tue, 26 Jun 2001 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbRFZV1J>; Tue, 26 Jun 2001 17:27:09 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:12293 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S265103AbRFZV07>; Tue, 26 Jun 2001 17:26:59 -0400
Date: Tue, 26 Jun 2001 17:26:54 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Rob Landley <landley@webofficenow.com>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org,
        penguicon-comphist@lists.sourceforge.net
Subject: Re: Microsoft and Xenix.
Message-ID: <20010626172654.B588@munchkin.spectacle-pond.org>
In-Reply-To: <E15DZbq-0008D8-00@roo.home> <01062310075401.00696@localhost.localdomain> <83WVxfbXw-B@khms.westfalen.de> <01062611162702.12583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01062611162702.12583@localhost.localdomain>; from landley@webofficenow.com on Tue, Jun 26, 2001 at 11:16:27AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 11:16:27AM -0400, Rob Landley wrote:
> On Monday 25 June 2001 15:23, Kai Henningsen wrote:
> 
> > The AS/400 is still going strong. It's a virtual machine based on a
> > relational database (among other things), mostly programmed in COBOL (I
> > think the C compiler has sizeof(void*) == 16 or something like that, so
> > you can put a database position in that pointer), it doesn't know the
> > difference between disk and memory (memory is *really* only a cache), and
> > these days it's usually running on PowerPC hardware.
> >
> > ISTR there's a gcc port for the AS/400. Oh, and it does have normal BSD
> > Sockets. These days, it's often sold as a web server.
> >
> > Main customer base seems to be medium large businesses and banks.
> 
> The AS400 seems to be based out of Austin.  We hear a lot about it around 
> here...

Ummm, the AS/400 was based out of Rochester, Minnesota at least initially.  It
was the follow to System/3 -> System/36 -> System/38, and customers originally
programmed it in RPG-III and Cobol.  Now that AS/400's are based on special
PowerPC's, the home may have moved to Austin, which is the PowerPC/AIX center.
The AS/400 line was intended to be the mid-range system, between the mainframes
(360 -> 370 -> 3080 -> 3900 -> ???) and the PCs.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
