Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130864AbQLHQaG>; Fri, 8 Dec 2000 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbQLHQ3r>; Fri, 8 Dec 2000 11:29:47 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22287 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129752AbQLHQ3h>;
	Fri, 8 Dec 2000 11:29:37 -0500
Message-ID: <3A310504.8AB07E6D@mandrakesoft.com>
Date: Fri, 08 Dec 2000 10:57:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: caperry@edolnx.net, linux-kernel@vger.kernel.org,
        Ben LaHaise <bcrl@redhat.com>
Subject: Re: Kernel Development Documentation?
In-Reply-To: <E144O3Q-0003vP-00@the-village.bc.nu> <00120816515701.00491@gimli>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Fri, 08 Dec 2000, Alan Cox wrote:
> > For the kernel stuff there is a project to put documentation about functions
> > and what they do inline into the kernel. Its slow progress. Trying to do
> > anything formal and structured isnt going to be productive until the
> > documentation is much much more complete

> Tigran Aivazian has been preparing 'Linux Kernel Internals' which is
> *highly recommended* and 100% free.  Why don't you get together with
> him, and Gary Lawrence Murphy (see his monthy kernel wiki nag)?
> 
> Personally, I try to do the right thing and submit at least one piece
> of documentation per month to somebody's documenation project but...
> it's not always so easy to free up the required hour or two.  This
> month my feeble attempt consisted of nagging Ben LaHaise to submit a
> particularly lucid email he sent me as a code comment.

Lucid e-mails often get stuck into Documentation/*, that's fine.

The preferred is 'make {pdf,ps,html}docs' as yanked from
Documentation/DocBook.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
