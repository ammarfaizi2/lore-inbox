Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbTAEBqm>; Sat, 4 Jan 2003 20:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTAEBql>; Sat, 4 Jan 2003 20:46:41 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:16393
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262528AbTAEBqi>; Sat, 4 Jan 2003 20:46:38 -0500
Date: Sat, 4 Jan 2003 17:54:02 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Rik van Riel <riel@conectiva.com.br>, Richard Stallman <rms@gnu.org>,
       andrew@indranet.co.nz, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <Pine.LNX.4.10.10301041740090.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik and Richard,

As you see, I in good faith prior to this holy war, had initiated a formal
request include a new protocol into the Linux kernel prior to the freeze.
The extention was requested to insure the product was of the highest
quality and not limited with excessive erratium as the ratification of the
IETF modified, postponed, and delayed ; regardless of reason.

Obviously, PyX had (has) on its schedule to product a high quality target
which is transport independent on each side of the protocol.  We are not
sure of this position because of the uncertain nature of the basic usages
of headers and export_symbols.

Regards,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

---------- Forwarded message ----------
Date: 23 Oct 2002 09:57:43 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@pyxtechnologies.com>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux iSCSI Initiator, OpenSource

On Wed, 2002-10-23 at 09:30, Andre Hedrick wrote:
> 
> Greetings Linus and Alan,
> 
> PyX Technologies is asking for a formal extention beyond the Oct 31st
> Feature Freeze.  The exception to the rules is generally granted to no
> one, and is well understood by PyX.  Only because PyX is under review for
> full funding on "Oct 31st" in the morning, would I even consider this
> motion.  Our position is to formally open source a full feature with all
> corner cases resolved under "error recovery level zero".

I can't see an iscsi initiator needing to touch core code anyway. Its
just another (slightly demented) scsi adapter


