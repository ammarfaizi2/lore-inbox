Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132764AbRASD5B>; Thu, 18 Jan 2001 22:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135755AbRASD4x>; Thu, 18 Jan 2001 22:56:53 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:59218 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132764AbRASD4h>; Thu, 18 Jan 2001 22:56:37 -0500
Message-ID: <3A67BAEE.519C777F@linux.com>
Date: Fri, 19 Jan 2001 03:56:30 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101181913540.16292-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:

> the reason, gag puke, is for doing things such as sending "activity"
> progress -- like a line at a time or whatever to indicate that the CGI is
> there and still working.

I understand the gagging on this and generally I agree.  I do appreciate having
the ability to do this however.  In some very infrequent cases it is nice to
have.  Perhaps a distinguished method to accomplish this can be created so only
this method does this while all others become more efficient and data transfer?

-d


--
..NOTICE fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
