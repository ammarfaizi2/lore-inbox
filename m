Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266768AbRGFRka>; Fri, 6 Jul 2001 13:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbRGFRkU>; Fri, 6 Jul 2001 13:40:20 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:25099 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S266768AbRGFRkF>; Fri, 6 Jul 2001 13:40:05 -0400
Date: Fri, 6 Jul 2001 19:39:22 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] Fix warnings in videobook
Message-ID: <20010706193922.E25204@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010706192232.D25204@arthur.ubicom.tudelft.nl> <E15IZMs-0004eu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15IZMs-0004eu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 06, 2001 at 06:26:14PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 06:26:14PM +0100, Alan Cox wrote:
> > All of which can be fixed by changing <> into <entry>. Patch applies
> > cleanly against 2.4.6, 2.4.7-pre3, and 2.4.6-ac1. Please apply, it even
> > makes the tables visible :)
> 
> That looks like tool problems. <></> is valid SGML short format, are you
> using XML docbook ?

Not that I am aware of, I'm using the SGML packages in Debian Potato
(2.2r3).

> I'll apply them anyway - they do no harm and short form SGML is evil in some
> books ;)

Thanks.


Erik
[not an SGML language lawyer ;) ]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
