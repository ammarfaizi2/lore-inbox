Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129746AbRB0SfJ>; Tue, 27 Feb 2001 13:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRB0Se7>; Tue, 27 Feb 2001 13:34:59 -0500
Received: from windsormachine.com ([206.48.122.28]:60934 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129746AbRB0Seq>; Tue, 27 Feb 2001 13:34:46 -0500
Message-ID: <3A9BF340.B8DD9F56@windsormachine.com>
Date: Tue, 27 Feb 2001 13:34:40 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
CC: Khalid Aziz <khalid@fc.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com> <3A9BC2A9.F5EE8554@fc.hp.com> <544rxg2gde.fsf@intech19.enhanced.com> <3A9BE4C1.1868F020@windsormachine.com> <54u25gvuyg.fsf@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Camm Maguire wrote:

> Greetings!  You are certainly right here, at least in part.  The ide
> patches for 2.2 definitely impair tape operation on these boxes.
> There was a crude workaround suggested on this list to use the
> ide-scsi driver -- this basically worked, but gave *many* error
> messages in the kernel log, and was significantly less reliable than
> stock 2.2.18.  I'm still using ide-scsi out of inertia, but I suspect
> that ide-tape might be just fine with stock 2.2.18 too.  And when I
> saw some support for the ALI chipset, the decision was clear to drop
> the latest ide stuff.
>
> This has been the situation for some time.  Is this going to be
> resolved soon?

Wish i knew, I'm praying that 2.2.19 hasn't/doesn't implement the ide patches like 2.4.x did.  If so, and a major problem is found in
2.2.18, then I have to maintain another machine running 2.2.18 to restore tapes.  Also means i'd have to stop using taper or dump,
and stick to tar only, as both want to read the tape back in at some point.

Mike

