Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281642AbRKUHJs>; Wed, 21 Nov 2001 02:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281641AbRKUHJ2>; Wed, 21 Nov 2001 02:09:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17296 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281643AbRKUHJQ>;
	Wed, 21 Nov 2001 02:09:16 -0500
Date: Tue, 20 Nov 2001 23:09:14 -0800 (PST)
Message-Id: <20011120.230914.00464304.davem@redhat.com>
To: jmerkey@timpanogas.org
Cc: jmerkey@vger.timpanogas.org, linux-kernel@vger.kernel.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
 opcode
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <003401c1725a$975ad4e0$f5976dcf@nwfs>
In-Reply-To: <000601c17259$59316630$f5976dcf@nwfs>
	<20011120.225655.85404918.davem@redhat.com>
	<003401c1725a$975ad4e0$f5976dcf@nwfs>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Jeff Merkey" <jmerkey@timpanogas.org>
   Date: Wed, 21 Nov 2001 00:03:15 -0700
   
   OK.  Cool.  Now we are making progress.  I think this is a nasty problem.
   There
   are numerous RPMs that will build against the kernel tree and be busted.

If you patch sources files of the main kernel, you have to
rebuild the dependencies.

Why does this seem illogical to you?
