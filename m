Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269968AbRHMIm6>; Mon, 13 Aug 2001 04:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269969AbRHMIms>; Mon, 13 Aug 2001 04:42:48 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:1799 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S269968AbRHMImh>; Mon, 13 Aug 2001 04:42:37 -0400
Message-ID: <3B7792B9.61721B85@idb.hist.no>
Date: Mon, 13 Aug 2001 10:41:29 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre8 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VM working much better in 2.4.8 than before
In-Reply-To: <20010811234822.A422@debian>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

misty-@charter.net wrote:
> 
>         I've said it before, I'll say it again - you guys deserve a
> 'this is a great thing' report once in a while. This is such a report :)

2.4.8 is good indeed.  My vmstat window tells me it ties up
about 40M less in page cache than earlier kernels, possibly an
effect of use-once.  (This is a 128M desktop machine.)

updatedb run still manages to use some swap, but the machine
is no longer sluggish in the morning. :-)

Helge Hafting
