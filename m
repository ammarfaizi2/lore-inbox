Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285883AbRLTC7a>; Wed, 19 Dec 2001 21:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285881AbRLTC7U>; Wed, 19 Dec 2001 21:59:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1922 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285883AbRLTC7J>;
	Wed, 19 Dec 2001 21:59:09 -0500
Date: Wed, 19 Dec 2001 18:58:47 -0800 (PST)
Message-Id: <20011219.185847.77651573.davem@redhat.com>
To: cs@zip.com.au
Cc: billh@tierra.ucsd.edu, bcrl@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011220135221.A23908@zapff.research.canon.com.au>
In-Reply-To: <20011220133705.A21648@zapff.research.canon.com.au>
	<20011219.184718.88473152.davem@redhat.com>
	<20011220135221.A23908@zapff.research.canon.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Cameron Simpson <cs@zip.com.au>
   Date: Thu, 20 Dec 2001 13:52:21 +1100
   
   tell me why async I/O is important
   to Java and not to anything else, which still seems the thrust of
   your remarks.

Not precisely my thrust, which is that AIO is not important to any
significant population of Linux users, it is "nook and cranny" in
scope.  And that those "nook and cranny" folks who really find it
important can get paid implementation+support of AIO.
