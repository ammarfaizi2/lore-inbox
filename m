Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSFCAs4>; Sun, 2 Jun 2002 20:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317241AbSFCAsz>; Sun, 2 Jun 2002 20:48:55 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:3243 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S312498AbSFCAsy>; Sun, 2 Jun 2002 20:48:54 -0400
Message-ID: <3CFABCF0.B39687AC@attbi.com>
Date: Sun, 02 Jun 2002 20:48:48 -0400
From: Colin Foran <nathantwist@attbi.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Gierth <andrew@erlenstar.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Wrote a server, but telnet can't connect
In-Reply-To: <24fda70e.0206021107.1222101f@posting.google.com> <87ofetwjxd.fsf@erlenstar.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> if you do the accept as a statement of its own, and then test the
> result in the if() condition, then you avoid this common novice trap.
> The days when there was a real advantage to combining the function
> call and the conditional test are long gone.
>
> --

thanks Andrew, really appreciate the interest.
I've changed the program as youve suggested, and even done away with the error
checking altogether, but Telnet still gets timed out. dont suppose youve seen
anything else that might trip it up?
Again, thanks for the interest
Cheers

