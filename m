Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290223AbSAOSB5>; Tue, 15 Jan 2002 13:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290222AbSAOSBl>; Tue, 15 Jan 2002 13:01:41 -0500
Received: from penguin.roanoke.edu ([199.111.154.8]:2575 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S290223AbSAOSB1>; Tue, 15 Jan 2002 13:01:27 -0500
Message-ID: <3C446E6B.1020709@roanoke.edu>
Date: Tue, 15 Jan 2002 13:01:15 -0500
From: "David L. Parsley" <parsley@roanoke.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Hans-Peter Jansen <hpj@urpla.net>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>	<E16QVf3-0002NG-00@charged.uio.no>	<15428.23828.941425.774587@laputa.namesys.com>	<20020115163208.785831435@shrek.lisa.de> <15428.27801.724105.557093@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita,

To be clear: if I upgrade the kernel on my nfs server to 2.4.latest and 
mount -o conv my reiserfs partition, that will almost certain fix my 
knfsd problem with a very small likelihood of generation problems?

regards,
	David
-- 
David L. Parsley
Network Administrator, Roanoke College
"If I have seen further it is by standing on ye shoulders of Giants."
--Isaac Newton

