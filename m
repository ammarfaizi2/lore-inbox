Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLXMTv>; Sun, 24 Dec 2000 07:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQLXMTm>; Sun, 24 Dec 2000 07:19:42 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:38925 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129585AbQLXMT1>; Sun, 24 Dec 2000 07:19:27 -0500
Date: Sun, 24 Dec 2000 12:48:29 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Jeffrey Rose <Jeffrey.Rose@t-online.de>
Cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linus Torvalds <torvalds@transmeta.com>,
        Michael Chen <michaelc@turbolinux.com.cn>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
Message-ID: <20001224124829.U25239@arthur.ubicom.tudelft.nl>
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn> <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com> <20001224002732.O25239@arthur.ubicom.tudelft.nl> <3A45C5AA.D0A5FDF3@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A45C5AA.D0A5FDF3@t-online.de>; from Jeffrey.Rose@t-online.de on Sun, Dec 24, 2000 at 10:45:14AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 10:45:14AM +0100, Jeffrey Rose wrote:
> I also have a Celeron 600 in my Compaq 5000, but even with the output
> below, I am not sure this is what Linus is talking about! I believe
> Linus is trying to say, "We HAVE configurations set for that specific
> architecture, so please USE them." However, I suppose you are saying you
> will get better performance from selecting PIII due to this output? Let
> me know ...

The confusion is because Intel reused the name Celeron for a completely
different CPU. The original Celeron was based on a PII core, the new
Celeron is based on a PIII core. Both Celerons have the same features
as the CPU they are based on, but with less cache memory. Selecting
PIII for the new PIII based Celeron will indeed give you slightly
better performance.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
