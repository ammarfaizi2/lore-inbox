Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRHALQi>; Wed, 1 Aug 2001 07:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266746AbRHALQ2>; Wed, 1 Aug 2001 07:16:28 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:6625 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266736AbRHALQW>; Wed, 1 Aug 2001 07:16:22 -0400
Date: Wed, 1 Aug 2001 12:16:29 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] DMCA loop hole
In-Reply-To: <3B67DE37.CA865F44@idb.hist.no>
Message-ID: <Pine.SOL.3.96.1010801120427.25852A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Helge Hafting wrote:
> James Simmons wrote:
> > Sorry this is off topic but this was way to good :-)
> > 
> >           Virus writers can use the DMCA in a perverse way. Because
> >    computer viruses are programs, they can be copyrighted just like a
> >    book, song, or movie. If a virus writer were to use encryption to hide
> >    the code of a virus, an anti-virus company could be forbidden by the
> >    DMCA to see how the virus works without first getting the permission
> >    of the virus writer. If they didn't, a virus writer could sue the
> >    anti-virus company under the DMCA!
> 
> They'd still be able to scan for it though - detecting the encrypted
> string or the decryption algorithm.

You just add a polymorphic decryption / encryption engine where you change
the encryption key every time you encrypt it. Also, morph the decription
code itself and you can't scan for it that easily without reverse
engineering it... For an added twist, encrypt it twice and put only a
minimal part of the first decryption algorithm in the unencrypted part of
the virus. Add to that some disassembler breaking code and you are off... 
Good that most viruses these days are written in Visual Basic rather than
assembler so they can't do any of that... (-: 

> What if I copyright & encrypt a DeCSS program?  Nobody can sue
> because they don't have permission to decrypt, and therefore
> cannot prove that it actually _is_ a decss algorithm? :-)

True, but if the program is actually useful in that people can use it to
do DeCSS like things then they would know it's a DeCSS like program
without seing the code and such a program would fall under DMCA. An
encrypted program which doesn't do anything unless you decrypt it by some
other program would not be very useful (ZIP/RAR/whatever can encrypt,
too...) but nobody could sue you for writing it either. (-; 

IANAL, etc,

	Anton (-:

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

