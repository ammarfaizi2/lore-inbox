Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135633AbRA0X36>; Sat, 27 Jan 2001 18:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135651AbRA0X3s>; Sat, 27 Jan 2001 18:29:48 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:26167 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135633AbRA0X3f>; Sat, 27 Jan 2001 18:29:35 -0500
Message-ID: <3A7359BB.7BBEE42A@linux.com>
Date: Sat, 27 Jan 2001 23:28:59 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@pobox.com>
CC: Shawn Starr <Shawn.Starr@Home.com>, Aaron Lehmann <aaronl@vitelus.com>,
        John Sheahan <john@reptechnic.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <20010126204324.B10046@vitelus.com> <3A72817E.CFCF0D52@pobox.com> <3A7285D4.9409E63A@linux.com> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've narrowed it down to "we're all running xmms" when it happend.

-d

J Sloan wrote:

> Just for the record, the system where I saw the problem
> has only ext2 -

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
