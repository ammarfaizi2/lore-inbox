Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132166AbRA0JeW>; Sat, 27 Jan 2001 04:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132307AbRA0JeM>; Sat, 27 Jan 2001 04:34:12 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:22494 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132166AbRA0JeF>; Sat, 27 Jan 2001 04:34:05 -0500
Message-ID: <3A7295F6.621BBEC4@Home.com>
Date: Sat, 27 Jan 2001 04:33:42 -0500
From: Shawn Starr <Shawn.Starr@Home.com>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: J Sloan <jjs@pobox.com>, Aaron Lehmann <aaronl@vitelus.com>,
        John Sheahan <john@reptechnic.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com> <3A72817E.CFCF0D52@pobox.com> <3A7285D4.9409E63A@linux.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have ReiserFS as well...hrm...

David Ford wrote:

> I can quickly and easily duplicate it on my notebook by playing music or
> mpegs in xmms.  It may take a few minutes but it's guaranteed.
>
> xmms stalls flat on it's face and anything accessing /proc stalls.  If I get
> the time to do it, I'll take a gander at it with kdb.
>
> I have no patches applied to p10, I have reiserfs onboard but I highly doubt
> it's reiserfs.
>
> -d
>
> J Sloan wrote:
>
> > OK, It's official now, I didn't know if it was some
> > weird hardware fluke or something, but one of
> > the computers here exhibited the same problem -
>
> --
>   There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
>   The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
