Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263055AbTCLAiJ>; Tue, 11 Mar 2003 19:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263054AbTCLAhx>; Tue, 11 Mar 2003 19:37:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263047AbTCLAhj>;
	Tue, 11 Mar 2003 19:37:39 -0500
Subject: Re: [PATCH] (8/8) Kill brlock
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303111644060.3002-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303111644060.3002-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047430098.15869.128.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:48:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 16:44, Linus Torvalds wrote:
> On Tue, 11 Mar 2003, David S. Miller wrote:
> >    
> > Ok, I'm fine with this then.  Linus you can apply all of his patches.
> 
> I'm a lazy bum, and I would _really_ want this tested more before it hits 
> my tree. I think it makes sense, but still..


I agree, given the number of sub-pieces it deserves some more time...

