Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRCBE5A>; Thu, 1 Mar 2001 23:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbRCBE4u>; Thu, 1 Mar 2001 23:56:50 -0500
Received: from joker.roanoke.edu ([199.111.154.17]:8717 "EHLO
	joker.roanoke.edu") by vger.kernel.org with ESMTP
	id <S130324AbRCBE4i>; Thu, 1 Mar 2001 23:56:38 -0500
Message-ID: <3A9F2821.A9B20002@linuxjedi.org>
Date: Thu, 01 Mar 2001 23:57:05 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-0.1.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Hans Reiser <reiser@namesys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mingo@redhat.com
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
In-Reply-To: <E14YYcH-0008NK-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip stuff about someone using linux for a web cache>

Alan Cox wrote:
> The extreme answer to the 2.4 networking performance is the tux specweb
> benchmarks but they dont answer for all cases clearly.

However, I think you've hit the nail on the head here; much of tux is
just general-purpose network file-blasting.  The right hacker could turn
it into the fastest web-cache on the planet with the right modules.  I
believe Ingo already did a basic ftp server based on tux, just to
demonstrate this generality.

Ingo?  Am I crazy or enlightened?

regards,
	David
