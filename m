Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRA2Vcs>; Mon, 29 Jan 2001 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130758AbRA2Vcj>; Mon, 29 Jan 2001 16:32:39 -0500
Received: from windsormachine.com ([206.48.122.28]:11795 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S129446AbRA2Vcd>; Mon, 29 Jan 2001 16:32:33 -0500
Message-ID: <3A75E156.65B3656@windsormachine.com>
Date: Mon, 29 Jan 2001 16:32:07 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert-Jan Oosterloo <oosterlo@worldonline.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide-tape problems with 2.4.0
In-Reply-To: <Pine.LNX.3.96.1010129214412.3024B-100000@zweden.rul.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into this problem awhile ago on a HP 7/14 as well, with the ide patches
as far back as 2.2.17.  Reported it, didn't get much in responses though :/

I'm just about at the point of giving up on the drives, but not due to Linux.
Those drives are not very durable, tend to die within a year around here.
Tapes last even less.  I've sent 4 drives out of 12 back to HP in the last
year, so far.

Robert-Jan Oosterloo wrote:

> Hi,
>
> I have a HP Colorado 4/8GB Travan tape streamer. Under 2.2.18 it works
> perfect. But under 2.4.0 it doesn't seem to want to read from the tape
> anymore.
>
> When I do a tar tvf /dev/tape, I get an I/O error and in syslog messages
> like:
>
> Jan 29 17:10:23 ijsland kernel: ide-tape: ht0: I/O error, pc =  8, key =
> 5, asc = 2c, ascq =  0.
>
> But writing to the tape works fine.
>
> Is this a known problem?
>
> Thanks!
>
> Robert-Jan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
