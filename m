Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156825AbPJDAhV>; Sun, 3 Oct 1999 20:37:21 -0400
Received: by vger.rutgers.edu id <S156709AbPJDAhB>; Sun, 3 Oct 1999 20:37:01 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:33917 "EHLO cygnus.com") by vger.rutgers.edu with ESMTP id <S156680AbPJDAgp>; Sun, 3 Oct 1999 20:36:45 -0400
Message-ID: <19991003203621.D1712@elmo.cygnus.com>
Date: Sun, 3 Oct 1999 20:36:21 -0400
From: Michael Meissner <meissner@cygnus.com>
To: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.rutgers.edu
Subject: Re: How do I boot over network
References: <19991002133802.A14240@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19991002133802.A14240@animx.eu.org>; from Wakko Warner on Sat, Oct 02, 1999 at 01:38:02PM -0400
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, Oct 02, 1999 at 01:38:02PM -0400, Wakko Warner wrote:
> I have an intel etherexpress 10/100 in a diskless machine.  It gets it's ip
> address and tftp's the kernel image.  Once it transfers control to the
> image, I get 8000 scrolling down the screen and the floppy drive is
> constantly on.

You might want to look at:

	http://nilo.on.openprojects.net/

NILO is the Network Interface Loader. NILO will boot Linux, FreeBSD, Windows
95/98/NT4 and support the Intel PXE standard, and is suitable for burning into
ROM. It is an evolution of the previous Etherboot and Netboot projects, and was
authored by Ken Yap, until Rob Savoye took over active development..

(I've not used it, but I used to work with Rob).

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
