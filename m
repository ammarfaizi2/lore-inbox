Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132707AbRDXQkt>; Tue, 24 Apr 2001 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbRDXQkj>; Tue, 24 Apr 2001 12:40:39 -0400
Received: from penguin.roanoke.edu ([199.111.154.8]:14855 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S132338AbRDXQkX>; Tue, 24 Apr 2001 12:40:23 -0400
Message-ID: <3AE5AF68.404AEF0E@linuxjedi.org>
Date: Tue, 24 Apr 2001 12:52:56 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104240639580.6992-100000@weyl.math.psu.edu> <m3n196v2un.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> OK I will do that for tmpfs soon. And I will do the symlink inlining
> with that patch.

Wow, this thread really exploded, eh?  But thanks, Christoph, I look
forward to seeing
your patch.  4k symlinks really suck for embedders who never swap out
pages. ;-)

regards,
	David

-- 
David L. Parsley
Network Administrator
Roanoke College
