Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268042AbRGVTEG>; Sun, 22 Jul 2001 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268043AbRGVTD5>; Sun, 22 Jul 2001 15:03:57 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:37644 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268042AbRGVTDj>; Sun, 22 Jul 2001 15:03:39 -0400
Message-ID: <3B5B229E.2511753@namesys.com>
Date: Sun, 22 Jul 2001 22:59:42 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Ian Chilton <ian@ichilton.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: Journaling FS Comparison
In-Reply-To: <20010722162150.A23381@woody.ichilton.co.uk>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Ian Chilton wrote:
 
> I also heard that ReiserFS is the fastest out of the bunch, but all
> data is lost on converstion, and obviously rescuing and moving disks is
> harder. But, it is in the main kernel tree..
tar works....:-)  and it has the advantage that you don't have to worry about a bug in the
conversion program, which was always the thing I feared enough to keep us from writing such a
conversion program.

The last ReiserFS patch for NFS in Linux 2.4 seems to have resulted in no more complaints regarding
nfs and reiserfs used in combination since it went in.  It went in quite recently though.

Hans
