Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261739AbTCLBMv>; Tue, 11 Mar 2003 20:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbTCLBMv>; Tue, 11 Mar 2003 20:12:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39873
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261691AbTCLBMu>; Tue, 11 Mar 2003 20:12:50 -0500
Subject: Re: [PATCH] (8/8) Kill brlock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, shemminger@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303111644060.3002-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303111644060.3002-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047436263.20968.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 02:31:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 00:44, Linus Torvalds wrote:
> On Tue, 11 Mar 2003, David S. Miller wrote:
> >    
> > Ok, I'm fine with this then.  Linus you can apply all of his patches.
> 
> I'm a lazy bum, and I would _really_ want this tested more before it hits 
> my tree. I think it makes sense, but still..

If Linus is scared ;) then throw them at me for -ac by all means. Anyone
running -ac IDE test sets is brave enough to run rcu network code 8)

