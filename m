Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRJNUEh>; Sun, 14 Oct 2001 16:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277295AbRJNUE2>; Sun, 14 Oct 2001 16:04:28 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:36868 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S277293AbRJNUEN>; Sun, 14 Oct 2001 16:04:13 -0400
Message-ID: <3BC9EFD7.D014C9C7@namesys.com>
Date: Mon, 15 Oct 2001 00:04:39 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Jens Benecke <jens@jensbenecke.de>
CC: linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [reiserfs-list] Re: ReiserFS data corruption in very simple 
 configuration
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <15276.34915.301069.643178@beta.reiserfs.com> <20010924112510.F15955@jensbenecke.de> <2143070000.1003071174@tiny> <20011014201907.H20001@jensbenecke.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Benecke wrote:
> What I meant is this: AFAIK, if you exclude broken hardware, in ext2 there
> is no chance of a file that was never written to since mounting being
> corrupted on a crash, even if the fs was mounted read-write.
> 
> Is this the same thing with ReiserFS?

Yes.
