Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbRFUAlB>; Wed, 20 Jun 2001 20:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263742AbRFUAkw>; Wed, 20 Jun 2001 20:40:52 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:46789 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S263212AbRFUAkh>; Wed, 20 Jun 2001 20:40:37 -0400
Message-ID: <3B3142DB.F4658CA4@idcomm.com>
Date: Wed, 20 Jun 2001 18:42:03 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <200106202120.f5KLKO5320707@saturn.cs.uml.edu> <0106201412240B.00776@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
...snip...
> The patches-linus-actuall-applies mailing list idea is based on how Linus
> says he works: he appends patches he likes to a file and then calls patch -p1
> < thatfile after a mail reading session.  It wouldn't be too much work for
> somebody to write a toy he could use that lets him work about the same way
> but forwards the messages to another folder where they can go out on an
> otherwise read-only list.  (No extra work for Linus.  This is EXTREMELY
> important, 'cause otherwise he'll never touch it.)

What if the file doing patches from is actually visible on a web page?
Or better yet, if the patch command itself was modified such that at the
same time it applies a patch, the source and the results were added to a
MySQL server which in turn shows as a web page?
