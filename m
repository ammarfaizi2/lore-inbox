Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288765AbSAID50>; Tue, 8 Jan 2002 22:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288766AbSAID5Q>; Tue, 8 Jan 2002 22:57:16 -0500
Received: from panther.fit.edu ([163.118.5.1]:55458 "EHLO fit.edu")
	by vger.kernel.org with ESMTP id <S288765AbSAID45>;
	Tue, 8 Jan 2002 22:56:57 -0500
Message-ID: <3C3BC0FC.30403@fit.edu>
Date: Tue, 08 Jan 2002 23:03:08 -0500
From: Kervin Pierre <kpierre@fit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020104
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fs corruption recovery?
In-Reply-To: <3C3BB082.8020204@fit.edu> <20020108200705.S769@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the reply,

 >Try "e2fsck -B 4096 -b 32768 <device>" instead.
 >

  e2fsck -B 4096 -b 32768  /dev/hdc1

e2fsck 1.25 (20-Sep-2001)
e2fsck: Attempt to read block from filesystem resulted in short read
while trying to open /dev/hdc1
Could this be a zero-length partition?


Does ext keep a backup of that backup?  :)

Are there any other options?

 >
 >Is the data really that valuable, and you don't have a backup?  It may
 >cost you several thousand dollars to do a recovery from such a company.
 >Yet, it isn't worth doing backups, it appears.
 >
Not the smartest thing I've done, I'll admit. :)

-Kervin



